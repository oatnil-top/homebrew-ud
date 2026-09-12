#!/bin/bash
#
# Update the Homebrew formula to <version>.
#
#   ./update-formula.sh <version>            verify the published bytes, then write the formula
#   ./update-formula.sh <version> --check    verify only, write nothing; exits non-zero if any
#                                            artifact is missing OR if the formula's pinned
#                                            sha256 no longer matches the published bytes
#
# Example: ./update-formula.sh 0.148.1
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
#   3. cross-check the local checksums file, if one is present -> disagreement
#                               means what we published is not what we built.
#   4. only then write Formula/ud.rb.
#
#   5. --check stops before step 4 and instead compares the four sha256 values
#      the CURRENT formula pins against the bytes just downloaded. That is the
#      comparison brew itself makes, so a green --check means `brew install ud`
#      works; "the URLs are all 200" does not mean that (b60c9811).
#
# Run it with --check any time to ask "does the current formula still resolve?"
# without changing anything.
#
# Download source: R2, deliberately. There is no public GitHub repo for the CLI
# (`oatnil-top/ud-cli` is a 404 and the source lives in the private monorepo),
# so GitHub release assets are not a thing brew could fetch anonymously. R2 is
# already where auto/upload-cli-to-r2.sh publishes and where checksums.txt
# already lives. See card 7a6ea4c7.
#
# ⚠️ auto/upload-cli-to-r2.sh prunes cli/releases/ to the newest KEEP_VERSIONS
# (default 10). Pin a version older than that and the formula 404s again — which
# is exactly what step 1 above will tell you.

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
CHECKSUMS_FILE="$SCRIPT_DIR/../tmp/cli-release/ud_${VERSION}_checksums.txt"
CDN_BASE_URL="https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases"

PLATFORMS="darwin_arm64 darwin_amd64 linux_arm64 linux_amd64"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

sha256_of() {
    if command -v shasum >/dev/null 2>&1; then
        shasum -a 256 "$1" | awk '{print $1}'
    else
        sha256sum "$1" | awk '{print $1}'
    fi
}

echo "Verifying published artifacts for $VERSION at $CDN_BASE_URL/$VERSION/ ..."
echo ""

FAILED=0
for plat in $PLATFORMS; do
    file="ud_${VERSION}_${plat}.tar.gz"
    url="$CDN_BASE_URL/$VERSION/$file"

    code="$(curl -s -o /dev/null -w '%{http_code}' -I "$url" || echo 000)"
    if [[ "$code" != "200" ]]; then
        echo "  ✗ $plat  HTTP $code  $url"
        echo "      The formula must never point at an object that is not there."
        echo "      Publish the release first: ./auto/upload-cli-to-r2.sh $VERSION r2"
        FAILED=1
        continue
    fi

    if ! curl -fsSL "$url" -o "$TMP_DIR/$file"; then
        echo "  ✗ $plat  HEAD said 200 but the download failed: $url"
        FAILED=1
        continue
    fi

    sha="$(sha256_of "$TMP_DIR/$file")"
    printf '  ✓ %-14s %s  (%s bytes)\n' "$plat" "$sha" "$(wc -c < "$TMP_DIR/$file" | tr -d ' ')"
    eval "SHA_${plat}=\$sha"
done

if [[ "$FAILED" -ne 0 ]]; then
    echo ""
    echo "Refusing to touch the formula: not every artifact is published and fetchable."
    exit 1
fi

# Cross-check against the local build, when this machine is the one that built it.
# A disagreement here means the bytes in the bucket are not the bytes we built --
# a re-upload, a partial upload, or the wrong version. Either is worth stopping for.
if [ -f "$CHECKSUMS_FILE" ]; then
    echo ""
    echo "Cross-checking against local build ($CHECKSUMS_FILE)..."
    for plat in $PLATFORMS; do
        local_sha="$(grep "ud_${VERSION}_${plat}.tar.gz" "$CHECKSUMS_FILE" | awk '{print $1}' || true)"
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
        echo "Refusing to touch the formula: published != built."
        exit 1
    fi
else
    echo ""
    echo "Note: no local checksums file at $CHECKSUMS_FILE — pinning the published bytes."
fi

# --check is the probe half of this script: it must answer "will `brew install ud`
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
# So: in check mode, read what the formula pins and diff it against what we just
# downloaded. Any disagreement -- a wrong version, a missing pin, a swapped
# object -- exits non-zero.
if [[ "$MODE" == "check" ]]; then
    echo ""
    echo "Comparing the current formula's pinned sha256 values against those bytes..."

    if [ ! -f "$FORMULA_FILE" ]; then
        echo "  ✗ no formula at $FORMULA_FILE"
        exit 1
    fi

    formula_version="$(awk '$1 == "version" { gsub(/"/, "", $2); print $2; exit }' "$FORMULA_FILE")"
    if [ "$formula_version" != "$VERSION" ]; then
        echo "  ✗ the formula pins version $formula_version, not $VERSION"
        echo "      Its sha256 values belong to a different release, so there is"
        echo "      nothing meaningful to compare. Regenerate: $0 $VERSION"
        exit 1
    fi

    # Pair each pinned sha256 with the url line above it rather than trusting the
    # order of the platform blocks -- the pin that matters for a platform is the
    # one brew reads after that platform's url.
    for plat in $PLATFORMS; do
        file="ud_${VERSION}_${plat}.tar.gz"
        pinned="$(awk -v f="$file" '
            index($0, f) > 0 { want = 1; next }
            want && $1 == "sha256" { gsub(/"/, "", $2); print $2; want = 0 }
        ' "$FORMULA_FILE")"
        published="$(eval "echo \$SHA_${plat}")"

        if [ -z "$pinned" ]; then
            echo "  ✗ $plat  the formula pins no sha256 for $file"
            FAILED=1
        elif [ "$pinned" != "$published" ]; then
            echo "  ✗ $plat  the formula pins bytes that are no longer served!"
            echo "      formula:   $pinned"
            echo "      published: $published"
            FAILED=1
        else
            printf '  ✓ %-14s matches the formula\n' "$plat"
        fi
    done

    if [[ "$FAILED" -ne 0 ]]; then
        echo ""
        echo "✗ brew install ud is broken for the platforms marked above:"
        echo "  brew will refuse the download with a SHA-256 mismatch."
        echo "  Fix by regenerating and pushing the formula: $0 $VERSION"
        exit 1
    fi

    echo ""
    echo "✓ $VERSION verifies, and the current formula pins exactly these bytes."
    echo "  (--check: formula not written.)"
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
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_darwin_arm64.tar.gz"
      sha256 "$DARWIN_ARM64_SHA"
    end
    on_intel do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_darwin_amd64.tar.gz"
      sha256 "$DARWIN_AMD64_SHA"
    end
  end

  on_linux do
    on_arm do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_linux_arm64.tar.gz"
      sha256 "$LINUX_ARM64_SHA"
    end
    on_intel do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_linux_amd64.tar.gz"
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

# Syntax-check what we just wrote. This is not ceremony: the heredoc above is
# UNQUOTED on purpose (it has to expand $VERSION and the sha variables), which
# means a backtick anywhere inside it is command substitution. A backtick in a
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
    if ! ruby -c "$FORMULA_FILE" >/dev/null 2>&1; then
        echo ""
        echo "✗ The generated formula is not valid Ruby:"
        ruby -c "$FORMULA_FILE" 2>&1 | sed 's/^/    /'
        echo "  (Check for backticks or \$ in the heredoc block of this script.)"
        exit 1
    fi
    echo ""
    echo "✓ Generated formula parses as Ruby"
fi

echo ""
echo "Formula updated to version $VERSION"
echo ""
echo "Next steps:"
echo "  1. cd homebrew-ud"
echo "  2. git add Formula/ud.rb"
echo "  3. git commit -m 'Update ud to $VERSION'"
echo "  4. git push"
