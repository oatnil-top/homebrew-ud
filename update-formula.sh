#!/bin/bash
# Update the Homebrew formula with new version and checksums
# Usage: ./update-formula.sh <version>
# Example: ./update-formula.sh 0.22.0

set -e

VERSION="${1}"
if [ -z "$VERSION" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.22.0"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FORMULA_FILE="$SCRIPT_DIR/Formula/ud.rb"
CHECKSUMS_FILE="$SCRIPT_DIR/../tmp/cli-release/ud_${VERSION}_checksums.txt"

if [ ! -f "$CHECKSUMS_FILE" ]; then
    echo "Error: Checksums file not found: $CHECKSUMS_FILE"
    echo "Make sure you've built the CLI first with: make release-cli-build version=$VERSION"
    exit 1
fi

# Extract checksums - match specific version to avoid mixing with other versions
DARWIN_ARM64_SHA=$(grep "ud_${VERSION}_darwin_arm64" "$CHECKSUMS_FILE" | awk '{print $1}')
DARWIN_AMD64_SHA=$(grep "ud_${VERSION}_darwin_amd64" "$CHECKSUMS_FILE" | awk '{print $1}')
LINUX_ARM64_SHA=$(grep "ud_${VERSION}_linux_arm64" "$CHECKSUMS_FILE" | awk '{print $1}')
LINUX_AMD64_SHA=$(grep "ud_${VERSION}_linux_amd64" "$CHECKSUMS_FILE" | awk '{print $1}')

if [ -z "$DARWIN_ARM64_SHA" ] || [ -z "$DARWIN_AMD64_SHA" ] || [ -z "$LINUX_ARM64_SHA" ] || [ -z "$LINUX_AMD64_SHA" ]; then
    echo "Error: Could not extract all checksums from $CHECKSUMS_FILE"
    exit 1
fi

CDN_BASE_URL="https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases"

cat > "$FORMULA_FILE" << EOF
# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "$VERSION"
  license "MIT"

  on_macos do
    on_arm do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_darwin_arm64.tar.gz"
      sha256 "$DARWIN_ARM64_SHA"

      def install
        bin.install "ud_${VERSION}_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_darwin_amd64.tar.gz"
      sha256 "$DARWIN_AMD64_SHA"

      def install
        bin.install "ud_${VERSION}_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_linux_arm64.tar.gz"
      sha256 "$LINUX_ARM64_SHA"

      def install
        bin.install "ud_${VERSION}_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "$CDN_BASE_URL/$VERSION/ud_${VERSION}_linux_amd64.tar.gz"
      sha256 "$LINUX_AMD64_SHA"

      def install
        bin.install "ud_${VERSION}_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
EOF

echo "Formula updated to version $VERSION"
echo ""
echo "Checksums:"
echo "  darwin_arm64: $DARWIN_ARM64_SHA"
echo "  darwin_amd64: $DARWIN_AMD64_SHA"
echo "  linux_arm64:  $LINUX_ARM64_SHA"
echo "  linux_amd64:  $LINUX_AMD64_SHA"
echo ""
echo "Next steps:"
echo "  1. cd homebrew-ud"
echo "  2. git add Formula/ud.rb"
echo "  3. git commit -m 'Update ud to $VERSION'"
echo "  4. git push"
