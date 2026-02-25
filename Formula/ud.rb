class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.2/ud_0.34.2_darwin_arm64.tar.gz"
      sha256 "f38b2f926b82a4da7fd1c1f9bc699b439617e7d8672e9a4b599efb0e64c25568"

      def install
        bin.install "ud_0.34.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.2/ud_0.34.2_darwin_amd64.tar.gz"
      sha256 "2d08717efaa81db39846ecea0dcd62a19c6ce86d3a1b4694eec2bcbcc6f6d95d"

      def install
        bin.install "ud_0.34.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.2/ud_0.34.2_linux_arm64.tar.gz"
      sha256 "cbb1feb9ee61ce1218f24cf1e8aa9e184731a0589f610ea59d1f60cd11f13855"

      def install
        bin.install "ud_0.34.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.2/ud_0.34.2_linux_amd64.tar.gz"
      sha256 "97645250830e315e8fd5de1be0f885f9a0298d8f6e7048d39da71ca9c5583f3e"

      def install
        bin.install "ud_0.34.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.2", shell_output("#{bin}/ud --version")
  end
end
