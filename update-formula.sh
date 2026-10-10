#!/bin/bash
#
# Update everything in the tap to <version>: Formula/ud.rb (the CLI),
# Formula/ud-server.rb (the self-hosted server) and Casks/undercontrol.rb (the
# macOS desktop app).
#
#   ./update-formula.sh <version>            verify the published bytes, then write all three
#   ./update-formula.sh <version> --check    verify only, write nothing; exits non-zero if any
#                                            artifact is missing OR if a formula's or the
#                                            cask's pinned sha256 no longer matches the
#                                            published bytes
#
# Example: ./update-formula.sh 0.148.1
#
# ONE VERSION, THREE FILES, ALL OR NOTHING
# ----------------------------------------
# A release ships the CLI, the server and the desktop app under one version
# number, so the tap pins all three to the same version. If any of them is not
# published yet, nothing is written: a tap where ud.rb says 0.162.0 and
# ud-server.rb still says 0.161.1 is a state nobody would recognise as "half a
# release" from the outside.
# The three come from different places and are published by different steps,
# so "the CLI is up" says nothing about the others:
#   ud           -> R2 (dl.udctl.com/cli/releases), release-cli.yml
#   ud-server    -> the npm registry, release-server.yml. The formula pulls the very
#                   @oatnil/ud-server-<os>-<cpu> tarball `npm i -g @oatnil/ud-server`
#                   installs, so brew and npm users run the same bytes. There is no R2
#                   copy of the server binary to point at instead.
#   undercontrol -> R2 (dl.udctl.com/releases/<version>/), auto/upload-electron-to-r2.sh
#                   after the release's desktop build. The cask pins the very
#                   notarized, stapled DMGs the download page links to, and the
#                   sha512 of those bytes must match the release's own
#                   latest-mac.yml (written by electron-builder, re-synced after
#                   stapling) -- the cask's equivalent of npm's dist.integrity.
#
# Caution: the desktop uploader keeps only the newest KEEP_VERSIONS (default 2)
# directories under releases/. A cask left two releases behind 404s, a much
# shorter horizon than the CLI's ten. Hence one script for all three: the cask
# moves exactly when the formulae do.
#
# The cask is named after the app bundle (UnDercontrol.app -> undercontrol), as
# Homebrew derives cask tokens. Not "udctl": the ud formula already installs a
# command called udctl, and `brew install udctl` giving you the desktop app
# would be a trap (owner, 2026-10-10, card 8664258c).
#
# WHY THIS SCRIPT DOWNLOADS BEFORE IT WRITES
# ------------------------------------------
# The previous edition read sha256 values out of the LOCAL build's checksums
# file and wrote them into the formula next to a CDN URL it never contacted.
# That makes the formula a claim about the CDN written from something that is
# not the CDN, and the claim went wrong: the tap sat pinned at 0.49.0 whose
# objects are not in the bucket at all -- every URL in it is a live 404, so
# `brew install ud` could not have worked even before the formula was disabled.
# Nothing in the old flow could have caught that, because nothing in the old
# flow ever asked the bucket a question.
#
# So the order is inverted. The published object is the source of truth:
#
#   1. HEAD each URL         -> 404 here means "publish the release first", and
#                               is a refusal, not a warning.
#   2. GET it and sha256 it  -> the formula pins the hash of bytes that were
#                               actually served, from the actual URL brew will
#                               use. A truncated upload or a re-uploaded
#                               different build cannot slip through.
#   3. cross-check an independent record of what was published -> disagreement
#                               means what is served is not what was built.
#        ud:        the local checksums file, if this machine built the release
#        ud-server: npm's own dist.integrity (sha512) for that tarball; this one
#                   is mandatory -- if the registry metadata cannot be read, that
#                   is "could not check", which refuses like a mismatch does
#   4. only then write the formulae.
#
#   5. --check stops before step 4 and instead compares the sha256 values the
#      CURRENT formulae pin against the bytes just downloaded. That is the
#      comparison brew itself makes, so a green --check means `brew install ud`
#      and `brew install ud-server` work; "the URLs are all 200" does not mean
#      that (b60c9811).
#
# Run it with --check any time to ask "does the current tap still resolve?"
# without changing anything.
#
# Download source for the CLI: R2, deliberately. There is no public GitHub repo
# for the CLI (`oatnil-top/ud-cli` is a 404 and the source lives in the private
# monorepo), so GitHub release assets are not a thing brew could fetch
# anonymously. R2 is already where auto/upload-cli-to-r2.sh publishes and where
# checksums.txt already lives. See card 7a6ea4c7.
#
# ⚠️ auto/upload-cli-to-r2.sh prunes cli/releases/ to the newest KEEP_VERSIONS
# (default 10). Pin a version older than that and the formula 404s again — which
# is exactly what step 1 above will tell you. npm versions are immutable and never
# pruned, so ud-server.rb has no such horizon.

set -euo pipefail

VERSION="${1:-}"
MODE="${2:-write}"

if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version> [--check]"
    echo "Example: $0 0.148.1"
    exit 1
fi

if [[ "$MODE" == "--check" ]]; then
    MODE="check"
elif [[ "$MODE" != "write" ]]; then
    echo "Error: unknown option '$MODE' (expected --check)"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA_FILE="$SCRIPT_DIR/Formula/ud.rb"
SERVER_FORMULA_FILE="$SCRIPT_DIR/Formula/ud-server.rb"
CHECKSUMS_FILE="$SCRIPT_DIR/../tmp/cli-release/ud_${VERSION}_checksums.txt"
CDN_BASE_URL="https://dl.udctl.com/cli/releases"
NPM_REGISTRY="https://registry.npmjs.org"
CASK_FILE="$SCRIPT_DIR/Casks/undercontrol.rb"
DESKTOP_BASE_URL="https://dl.udctl.com/releases"
# electron-builder's arch names; the cask's `arch arm:, intel:` maps onto these.
DESKTOP_ARCHES="arm64 x64"

PLATFORMS="darwin_arm64 darwin_amd64 linux_arm64 linux_amd64"

# Homebrew platform -> npm subpackage suffix (go-backend/npm/platform.js names them
# after node's process.platform/process.arch, hence x64 rather than amd64).
npm_suffix() {
    case "$1" in
        darwin_arm64) echo darwin-arm64 ;;
        darwin_amd64) echo darwin-x64 ;;
        linux_arm64)  echo linux-arm64 ;;
        linux_amd64)  echo linux-x64 ;;
    esac
}
ud_file()         { echo "ud_${VERSION}_$1.tar.gz"; }
ud_url()          { echo "$CDN_BASE_URL/$VERSION/$(ud_file "$1")"; }
server_file()     { echo "ud-server-$(npm_suffix "$1")-${VERSION}.tgz"; }
server_url()      { echo "$NPM_REGISTRY/@oatnil/ud-server-$(npm_suffix "$1")/-/$(server_file "$1")"; }
server_meta_url() { echo "$NPM_REGISTRY/@oatnil/ud-server-$(npm_suffix "$1")/$VERSION"; }

dmg_file()         { echo "undercontrol-desktop-${VERSION}-$1.dmg"; }
dmg_url()          { echo "$DESKTOP_BASE_URL/$VERSION/$(dmg_file "$1")"; }
desktop_manifest() { echo "$DESKTOP_BASE_URL/$VERSION/latest-mac.yml"; }

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

sha256_of() {
    if command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | awk '{print $1}'
    else
        sha256sum "$1" | awk '{print $1}'
    fi
}

FAILED=0

# fetch <var-name> <url> <label>: steps 1 and 2. Sets <var-name> to the sha256 of
# the downloaded bytes, or marks FAILED. The file stays in $TMP_DIR for step 3.
fetch() {
    local var="$1" url="$2" label="$3" file code sha
    file="$TMP_DIR/$(basename "$url")"

    code="$(curl -s -o /dev/null -w '%{http_code}' -I "$url" || echo 000)"
    if [[ "$code" != "200" ]]; then
        echo "  ✗ $label  HTTP $code  $url"
        echo "      The formula must never point at an object that is not there."
        echo "      Publish the release first."
        FAILED=1
        return
    fi

    if ! curl -fsSL "$url" -o "$file"; then
        echo "  ✗ $label  HEAD said 200 but the download failed: $url"
        FAILED=1
        return
    fi

    sha="$(sha256_of "$file")"
    printf '  ✓ %-24s %s  (%s bytes)\n' "$label" "$sha" "$(wc -c < "$file" | tr -d ' ')"
    eval "$var=\$sha"
}

echo "Verifying published artifacts for $VERSION ..."
echo "  ud        <- $CDN_BASE_URL/$VERSION/"
echo "  ud-server <- $NPM_REGISTRY/@oatnil/ud-server-<os>-<cpu>/"
echo "  undercontrol (cask) <- $DESKTOP_BASE_URL/$VERSION/  (two DMGs, ~270 MB each)"
echo ""

for plat in $PLATFORMS; do
    fetch "SHA_${plat}" "$(ud_url "$plat")" "ud $plat"
done
for plat in $PLATFORMS; do
    fetch "SRV_SHA_${plat}" "$(server_url "$plat")" "ud-server $plat"
done
for arch in $DESKTOP_ARCHES; do
    fetch "DMG_SHA_${arch}" "$(dmg_url "$arch")" "undercontrol $arch"
done

if [[ "$FAILED" -ne 0 ]]; then
    echo ""
    echo "Refusing to touch any of the three: not every artifact is published and fetchable."
    echo "  ud missing           -> ./auto/upload-cli-to-r2.sh $VERSION r2 (or wait for release-cli.yml)"
    echo "  ud-server missing    -> wait for / re-run release-server.yml (npm publish)"
    echo "  undercontrol missing -> ./auto/upload-electron-to-r2.sh $VERSION r2 (after the desktop build)"
    exit 1
fi

# Cross-check against the local build, when this machine is the one that built it.
# A disagreement here means the bytes in the bucket are not the bytes we built --
# a re-upload, a partial upload, or the wrong version. Either is worth stopping for.
if [ -f "$CHECKSUMS_FILE" ]; then
    echo ""
    echo "Cross-checking ud against local build ($CHECKSUMS_FILE)..."
    for plat in $PLATFORMS; do
        local_sha="$(grep "$(ud_file "$plat")" "$CHECKSUMS_FILE" | awk '{print $1}' || true)"
        published_sha="$(eval "echo \$SHA_${plat}")"
        if [ -z "$local_sha" ]; then
            echo "  - $plat  not in the local checksums file, skipping"
        elif [ "$local_sha" != "$published_sha" ]; then
            echo "  ✗ $plat  published bytes differ from the local build!"
            echo "      local:     $local_sha"
            echo "      published: $published_sha"
            FAILED=1
        else
            echo "  ✓ $plat  matches the local build"
        fi
    done
    if [[ "$FAILED" -ne 0 ]]; then
        echo ""
        echo "Refusing to touch any of the three: published != built."
        exit 1
    fi
else
    echo ""
    echo "Note: no local checksums file at $CHECKSUMS_FILE — pinning the published ud bytes."
fi

# ud-server: npm's dist.integrity is the registry's own record of the tarball it
# serves. Matching it proves the formula pins exactly what `npm i -g` installs.
echo ""
echo "Cross-checking ud-server against npm's dist.integrity (sha512)..."
for plat in $PLATFORMS; do
    meta="$(curl -fsSL "$(server_meta_url "$plat")" 2>/dev/null || true)"
    want="$(printf '%s' "$meta" | grep -o '"integrity":"sha512-[^"]*"' | head -1 | sed 's/^"integrity":"sha512-//; s/"$//')"
    got="$(openssl dgst -sha512 -binary "$TMP_DIR/$(server_file "$plat")" | base64 | tr -d '\n')"
    if [ -z "$want" ]; then
        echo "  ✗ $plat  could not read dist.integrity from $(server_meta_url "$plat")"
        echo "      Could not check is not a pass."
        FAILED=1
    elif [ "$want" != "$got" ]; then
        echo "  ✗ $plat  downloaded bytes differ from npm's dist.integrity!"
        echo "      npm:        sha512-$want"
        echo "      downloaded: sha512-$got"
        FAILED=1
    else
        echo "  ✓ $plat  matches npm's dist.integrity"
    fi
done
if [[ "$FAILED" -ne 0 ]]; then
    echo ""
    echo "Refusing to touch any of the three: ud-server bytes could not be tied to npm's record."
    exit 1
fi

# undercontrol: the release's own latest-mac.yml is electron-builder's record of
# each DMG (sha512 in base64, and size), re-synced after stapling rewrote the
# bytes. Mandatory, like dist.integrity: unreadable is "could not check", which
# refuses. A mismatch means what is served is not what the release recorded --
# typically a DMG re-uploaded without re-syncing the manifest.
echo ""
echo "Cross-checking undercontrol DMGs against $(desktop_manifest) ..."
manifest="$(curl -fsSL "$(desktop_manifest)" 2>/dev/null || true)"
for arch in $DESKTOP_ARCHES; do
    file="$(dmg_file "$arch")"
    # The files: list has "- url: <file>" then "sha512:" and "size:" lines.
    want="$(printf '%s\n' "$manifest" | awk -v f="$file" '
        $1 == "-" && $2 == "url:" { cur = $3; next }
        cur == f && $1 == "sha512:" { print $2; exit }
    ')"
    want_size="$(printf '%s\n' "$manifest" | awk -v f="$file" '
        $1 == "-" && $2 == "url:" { cur = $3; next }
        cur == f && $1 == "size:" { print $2; exit }
    ')"
    got="$(openssl dgst -sha512 -binary "$TMP_DIR/$file" | base64 | tr -d '\n')"
    got_size="$(wc -c < "$TMP_DIR/$file" | tr -d ' ')"
    if [ -z "$want" ] || [ -z "$want_size" ]; then
        echo "  ✗ $arch  no sha512/size for $file in $(desktop_manifest)"
        echo "      Could not check is not a pass."
        FAILED=1
    elif [ "$want" != "$got" ] || [ "$want_size" != "$got_size" ]; then
        echo "  ✗ $arch  downloaded DMG differs from latest-mac.yml!"
        echo "      manifest:   sha512 $want  size $want_size"
        echo "      downloaded: sha512 $got  size $got_size"
        FAILED=1
    else
        echo "  ✓ $arch  matches latest-mac.yml (sha512 and size)"
    fi
done
if [[ "$FAILED" -ne 0 ]]; then
    echo ""
    echo "Refusing to touch any of the three: the DMGs could not be tied to the release's latest-mac.yml."
    exit 1
fi

# check_pins <formula> <var-prefix> <file-fn>: the --check comparison for one formula.
# Pairs each pinned sha256 with the url line above it rather than trusting the
# order of the platform blocks -- the pin that matters for a platform is the one
# brew reads after that platform's url.
check_pins() {
    local formula="$1" prefix="$2" file_fn="$3" name formula_version file pinned published
    name="$(basename "$formula" .rb)"

    if [ ! -f "$formula" ]; then
        echo "  ✗ no formula at $formula"
        FAILED=1
        return
    fi

    formula_version="$(awk '$1 == "version" { gsub(/"/, "", $2); print $2; exit }' "$formula")"
    # ud-server.rb has no version line: brew audit --strict rejects it as redundant
    # with the npm tarball name, so read it from there (...-<version>.tgz).
    if [ -z "$formula_version" ]; then
        formula_version="$(grep -m1 -o -- '-[0-9][0-9.]*[0-9]\.tgz"' "$formula" | sed 's/^-//; s/\.tgz"$//' || true)"
    fi
    if [ "$formula_version" != "$VERSION" ]; then
        echo "  ✗ $name  the formula pins version $formula_version, not $VERSION"
        echo "      Its sha256 values belong to a different release, so there is"
        echo "      nothing meaningful to compare. Regenerate: $0 $VERSION"
        FAILED=1
        return
    fi

    for plat in $PLATFORMS; do
        file="$("$file_fn" "$plat")"
        pinned="$(awk -v f="$file" '
            index($0, f) > 0 { want = 1; next }
            want && $1 == "sha256" { gsub(/"/, "", $2); print $2; want = 0 }
        ' "$formula")"
        published="$(eval "echo \$${prefix}${plat}")"

        if [ -z "$pinned" ]; then
            echo "  ✗ $name $plat  the formula pins no sha256 for $file"
            FAILED=1
        elif [ "$pinned" != "$published" ]; then
            echo "  ✗ $name $plat  the formula pins bytes that are no longer served!"
            echo "      formula:   $pinned"
            echo "      published: $published"
            FAILED=1
        else
            printf '  ✓ %-24s matches the formula\n' "$name $plat"
        fi
    done
}

# --check is the probe half of this script: it must answer "will `brew install`
# work right now?", and downloading the bytes does not answer that on its own.
# What brew actually compares is the sha256 PINNED IN THE FORMULA against the
# bytes the URL serves today, so that is the comparison --check has to make.
#
# It did not, until 2026-09-09, and the gap was not theoretical: on 0.149.0 the
# formula was generated from the artifacts of a CI run that was later re-run,
# and the re-run overwrote every tarball in cli/releases/0.149.0/ with new bytes.
# The URLs still answered 200, the downloads still hashed fine, --check still
# printed a wall of green ticks -- and `brew install ud` failed on all four
# platforms with "SHA-256 mismatch". Nothing pointed at the object being swapped
# under a formula that was correct when it was written. See card b60c9811.
#
# So: in check mode, read what each formula pins and diff it against what we just
# downloaded. Any disagreement -- a wrong version, a missing pin, a swapped
# object -- exits non-zero.
# check_cask: the same comparison for Casks/undercontrol.rb, whose shape differs:
# one url built from #{version}/#{arch}, and one sha256 line carrying both arches
# (sha256 arm: "...", intel: "..."), so the pin is read by its arch key.
check_cask() {
    local cask_version arch key pinned published
    if [ ! -f "$CASK_FILE" ]; then
        echo "  ✗ no cask at $CASK_FILE"
        FAILED=1
        return
    fi
    cask_version="$(awk '$1 == "version" { gsub(/"/, "", $2); print $2; exit }' "$CASK_FILE")"
    if [ "$cask_version" != "$VERSION" ]; then
        echo "  ✗ undercontrol  the cask pins version $cask_version, not $VERSION"
        echo "      Regenerate: $0 $VERSION"
        FAILED=1
        return
    fi
    for arch in $DESKTOP_ARCHES; do
        case "$arch" in arm64) key=arm ;; x64) key=intel ;; esac
        pinned="$(grep -o "${key}: *\"[0-9a-f]*\"" "$CASK_FILE" | head -1 | sed 's/.*"\([0-9a-f]*\)"/\1/' || true)"
        published="$(eval "echo \$DMG_SHA_${arch}")"
        if [ -z "$pinned" ]; then
            echo "  ✗ undercontrol $arch  the cask pins no sha256 for $key"
            FAILED=1
        elif [ "$pinned" != "$published" ]; then
            echo "  ✗ undercontrol $arch  the cask pins bytes that are no longer served!"
            echo "      cask:      $pinned"
            echo "      published: $published"
            FAILED=1
        else
            printf '  ✓ %-24s matches the cask\n' "undercontrol $arch"
        fi
    done
}

if [[ "$MODE" == "check" ]]; then
    echo ""
    echo "Comparing the current formulae's and cask's pinned sha256 values against those bytes..."
    check_pins "$FORMULA_FILE" "SHA_" ud_file
    check_pins "$SERVER_FORMULA_FILE" "SRV_SHA_" server_file
    check_cask

    if [[ "$FAILED" -ne 0 ]]; then
        echo ""
        echo "✗ brew install is broken for what is marked above:"
        echo "  brew will refuse the download with a SHA-256 mismatch (or fetch the wrong version)."
        echo "  Fix by regenerating and pushing the tap: $0 $VERSION"
        exit 1
    fi

    echo ""
    echo "✓ $VERSION verifies, and both formulae and the cask pin exactly these bytes."
    echo "  (--check: nothing written.)"
    exit 0
fi

DARWIN_ARM64_SHA="$(eval "echo \$SHA_darwin_arm64")"
DARWIN_AMD64_SHA="$(eval "echo \$SHA_darwin_amd64")"
LINUX_ARM64_SHA="$(eval "echo \$SHA_linux_arm64")"
LINUX_AMD64_SHA="$(eval "echo \$SHA_linux_amd64")"

cat > "$FORMULA_FILE" << EOF
# typed: false
# frozen_string_literal: true

# Generated by update-formula.sh -- do not hand-edit.
# Every sha256 below is the hash of bytes actually downloaded from the url above
# it, at the moment this file was written. See update-formula.sh for why.

class Ud < Formula
  desc "AI agent CLI for udctl - tasks, notes and expenses from the terminal"
  homepage "https://udctl.com/docs/cli/"
  version "$VERSION"
  license :cannot_represent

  # url/sha256 only in the platform blocks, and ONE class-level def install.
  # A def install nested inside an on_arm/on_intel block installs fine but fails
  # brew audit ("Do not define methods in blocks") -- four times, once per block.
  # The filename the archive unpacks to is derivable, so derive it.
  on_macos do
    on_arm do
      url "$(ud_url darwin_arm64)"
      sha256 "$DARWIN_ARM64_SHA"
    end
    on_intel do
      url "$(ud_url darwin_amd64)"
      sha256 "$DARWIN_AMD64_SHA"
    end
  end

  on_linux do
    on_arm do
      url "$(ud_url linux_arm64)"
      sha256 "$LINUX_ARM64_SHA"
    end
    on_intel do
      url "$(ud_url linux_amd64)"
      sha256 "$LINUX_AMD64_SHA"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "ud_#{version}_#{os}_#{arch}" => "ud"
    # The product is called udctl; the command itself stays ud. Ship both names off
    # the one binary so "which udctl" resolves after a plain brew install ud.
    # (No backticks in this heredoc -- see the note under it.)
    bin.install_symlink bin/"ud" => "udctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
    # The alias is part of what we ship, so test it, not just the real name.
    assert_match version.to_s, shell_output("#{bin}/udctl --version")
  end
end
EOF

# ud-server.rb is written from a QUOTED heredoc with @@PLACEHOLDERS@@ filled in by
# sed afterwards, unlike ud.rb above: its post-install step carries a shell
# script, and in an unquoted heredoc every $ and $( ) in that script would be
# expanded right here, at generation time. Quoted, nothing inside is shell.
cat > "$SERVER_FORMULA_FILE" << 'EOF'
# typed: false
# frozen_string_literal: true

# Generated by update-formula.sh -- do not hand-edit.
# Every sha256 below is the hash of bytes actually downloaded from the url above
# it, at the moment this file was written, and those bytes were matched against
# npm's own dist.integrity. See update-formula.sh for why.

class UdServer < Formula
  desc "Self-hosted UnDercontrol server - tasks, notes and the web app in one binary"
  homepage "https://udctl.com/"
  license :cannot_represent

  # The same per-platform tarball npm installs for @oatnil/ud-server, so brew and
  # npm users run identical bytes. It unpacks to package/, which brew steps into.
  on_macos do
    on_arm do
      url "@@URL_darwin_arm64@@"
      sha256 "@@SHA_darwin_arm64@@"
    end
    on_intel do
      url "@@URL_darwin_amd64@@"
      sha256 "@@SHA_darwin_amd64@@"
    end
  end

  on_linux do
    on_arm do
      url "@@URL_linux_arm64@@"
      sha256 "@@SHA_linux_arm64@@"
    end
    on_intel do
      url "@@URL_linux_amd64@@"
      sha256 "@@SHA_linux_amd64@@"
    end
  end

  def install
    bin.install "bin/ud-server"
  end

  # The server loads .env from its working directory and the service runs in
  # etc/ud-server, so that file is the configuration. Real environment variables
  # still win over it. Data lives in var/, outside the keg, so an upgrade never
  # touches data; the .env is only ever created, never rewritten.
  # Writes etc/ud-server/.env on first install only. A brew service is running
  # from the moment the user logs in, so JWT_SECRET is generated per install
  # rather than left at the server's built-in fixed string; mode 600, since the
  # file holds it. Random bytes come from /dev/urandom through od, so nothing
  # beyond a POSIX shell is needed on macOS or Linux.
  # PERSONAL_TIER_PASSWORD is deliberately NOT set: without a license the
  # self-hosted default login is the owner's intended design (2026-10-10, card
  # c507cff5), same as the npm package. Do not "fix" it here.
  # The server cannot be told which address to bind (it listens on ":" + PORT),
  # so it is reachable from the network; that is said in caveats, not hidden.
  # (The script is a literal inside the run step: audit rejects anything else there.)
  post_install_steps do
    mkdir_p "ud-server", base: :var
    mkdir_p "log", base: :var
    mkdir_p "ud-server", base: :etc
    unless_path_exists "ud-server/.env", base: :etc do
      run "/bin/sh", args: ["-c", <<~'SH', "sh", "{{etc}}/ud-server", "{{var}}/ud-server"],
        set -eu
        umask 077
        f="$1/.env"
        [ -e "$f" ] && exit 0
        rnd() { head -c "$1" /dev/urandom | od -An -tx1 | tr -d ' \n'; }
        {
          echo "# ud-server configuration, read at start by: brew services start ud-server"
          echo "# Edit, then: brew services restart ud-server"
          echo "# Every key is also a CLI flag / env var; see ud-server -h."
          echo "# Generated once at install; brew upgrade never rewrites this file."
          echo
          echo "PORT=8080"
          echo "# The URL users reach this server at. Change it when exposing beyond localhost."
          echo "HOST_DOMAIN=http://localhost:8080"
          echo "UD_DATA_PATH=$2"
          echo
          echo "# Signs login tokens. Generated for this install; keep this file private."
          echo "JWT_SECRET=$(rnd 32)"
        } > "$f.tmp"
        mv "$f.tmp" "$f"
      SH
                     writable_paths: ["ud-server"], writable_base: :etc
    end
  end

  def caveats
    <<~EOS
      Configuration: #{etc}/ud-server/.env
      Data:          #{var}/ud-server
      Logs:          #{var}/log/ud-server.log

      Start now and at login:  brew services start ud-server
      Then open http://localhost:8080 (personal@undercontrol.local / personal123).
      After adding a license (LICENSE_TOKEN) to that file, the server runs as Pro and
      requires ADMIN_EMAIL and ADMIN_PASSWORD there too; log in with those instead.

      The server listens on all network interfaces, not only localhost, so other
      machines on your network can reach port 8080. To serve them on purpose, set
      HOST_DOMAIN in that file to the URL they use, then brew services restart ud-server.
    EOS
  end

  service do
    run opt_bin/"ud-server"
    working_dir etc/"ud-server"
    keep_alive true
    log_path var/"log/ud-server.log"
    error_log_path var/"log/ud-server.log"
  end

  test do
    port = free_port
    (testpath/"data").mkpath
    pid = spawn({ "PORT" => port.to_s, "HOST_DOMAIN" => "http://localhost:#{port}",
                  "UD_DATA_PATH" => (testpath/"data").to_s, "UD_CONFIG_FILE_DISCOVERY" => "false" },
                bin/"ud-server", out: File::NULL, err: File::NULL)
    begin
      out = ""
      30.times do
        sleep 1
        out = Utils.popen_read("curl", "-fs", "http://127.0.0.1:#{port}/api/v1/version")
        break if out.include?(version.to_s)
      end
      assert_match "\"version\":\"#{version}\"", out
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
EOF

for plat in $PLATFORMS; do
    sha="$(eval "echo \$SRV_SHA_${plat}")"
    url="$(server_url "$plat")"
    sed -i.bak -e "s|@@URL_${plat}@@|${url}|" -e "s|@@SHA_${plat}@@|${sha}|" "$SERVER_FORMULA_FILE"
done
rm -f "$SERVER_FORMULA_FILE.bak"
if grep -q '@@' "$SERVER_FORMULA_FILE"; then
    echo ""
    echo "✗ Unfilled placeholders left in $SERVER_FORMULA_FILE:"
    grep -n '@@' "$SERVER_FORMULA_FILE" | sed 's/^/    /'
    exit 1
fi

# Casks/undercontrol.rb: quoted heredoc + sed, like ud-server.rb, so the Ruby
# #{version}/#{arch} interpolation stays literal and nothing in it is shell.
#
# No auto_updates: the desktop app does not update itself. Its "Check for
# Updates" only reads releases/latest/latest-mac.yml and opens udctl.com/download
# in the browser (ud-electron-vite/src/main/update-checker.js), so brew is the
# only thing that upgrades a brew-installed copy, and `brew upgrade` must see it.
# A user who installs a newer DMG by hand over it leaves brew's record one
# version behind; the next `brew upgrade` reinstalls over it, nothing breaks.
#
# No `binary` stanza: the app offers to symlink its bundled CLI to
# /usr/local/bin/ud itself, and the ud formula owns the CLI in this tap.
#
# zap lists only paths the app is known to write (checked on a machine running
# it, 2026-10-10). The data directory can be moved by the user (data-path.js);
# a moved one is the user's, and zap does not chase it.
mkdir -p "$(dirname "$CASK_FILE")"
cat > "$CASK_FILE" << 'EOF'
# Generated by update-formula.sh -- do not hand-edit.
# Every sha256 below is the hash of bytes actually downloaded from the url, at
# the moment this file was written, and those bytes were matched against the
# release's own latest-mac.yml. See update-formula.sh for why.

cask "undercontrol" do
  arch arm: "arm64", intel: "x64"

  version "@@VERSION@@"
  sha256 arm:   "@@SHA_arm64@@",
         intel: "@@SHA_x64@@"

  url "https://dl.udctl.com/releases/#{version}/undercontrol-desktop-#{version}-#{arch}.dmg"
  name "UnDercontrol"
  desc "Desktop app for udctl tasks, notes and AI agents"
  homepage "https://udctl.com/"

  livecheck do
    url "https://dl.udctl.com/releases/latest/latest-mac.yml"
    strategy :electron_builder
  end

  depends_on macos: :monterey

  app "UnDercontrol.app"

  zap trash: [
    "~/Library/Application Support/undercontrol-desktop",
    "~/Library/Preferences/com.undercontrol.app.plist",
    "~/Library/Saved Application State/com.undercontrol.app.savedState",
  ]
end
EOF
sed -i.bak -e "s|@@VERSION@@|${VERSION}|" "$CASK_FILE"
for arch in $DESKTOP_ARCHES; do
    sha="$(eval "echo \$DMG_SHA_${arch}")"
    sed -i.bak -e "s|@@SHA_${arch}@@|${sha}|" "$CASK_FILE"
done
rm -f "$CASK_FILE.bak"
if grep -q '@@' "$CASK_FILE"; then
    echo ""
    echo "✗ Unfilled placeholders left in $CASK_FILE:"
    grep -n '@@' "$CASK_FILE" | sed 's/^/    /'
    exit 1
fi

# Syntax-check what we just wrote. This is not ceremony: the heredocs above are
# UNQUOTED on purpose (they have to expand $VERSION and the sha variables), which
# means a backtick anywhere inside them is command substitution. A backtick in a
# comment once ran `brew audit` mid-generation and spliced ~40 lines of audit
# output from unrelated taps straight into Formula/ud.rb. The file still looked
# plausible at a glance and git would have committed it happily. Ruby would not.
#
# Limit, stated honestly: this catches a MULTI-line splice (proven by kill-it on
# 2026-09-07 -- injecting a backticked command whose output is several lines makes
# ruby -c exit 1 and this script refuse). A one-line splice inside a comment stays
# syntactically valid and would slip through. The real rule is still "no backticks
# in the heredoc"; ruby -c is the net under it.
if command -v ruby >/dev/null 2>&1; then
    for f in "$FORMULA_FILE" "$SERVER_FORMULA_FILE" "$CASK_FILE"; do
        if ! ruby -c "$f" >/dev/null 2>&1; then
            echo ""
            echo "✗ The generated file is not valid Ruby: $f"
            ruby -c "$f" 2>&1 | sed 's/^/    /'
            echo "  (Check for backticks or \$ in the heredoc blocks of this script.)"
            exit 1
        fi
    done
    echo ""
    echo "✓ Both generated formulae and the cask parse as Ruby"
fi

echo ""
echo "Tap updated to version $VERSION (ud.rb, ud-server.rb, Casks/undercontrol.rb)"
echo ""
echo "Next steps:"
echo "  1. cd homebrew-ud"
echo "  2. git add Formula/ Casks/"
echo "  3. git commit -m 'Update ud, ud-server and undercontrol to $VERSION'"
echo "  4. git push"
