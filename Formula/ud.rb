class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.0/ud_0.34.0_darwin_arm64.tar.gz"
      sha256 "ce91dd1f7eff37368d8fd894847c3aa82d428c16a1314b3132e71be98af8b11d"

      def install
        bin.install "ud_0.34.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.0/ud_0.34.0_darwin_amd64.tar.gz"
      sha256 "502325678f28ef4e7abf55920569437c879217c13b97110bdb2cf3cd7278c1ba"

      def install
        bin.install "ud_0.34.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.0/ud_0.34.0_linux_arm64.tar.gz"
      sha256 "7c29bdcbbc48823e8b2b8a47b4a61acee8c9f53737509303c233c5e6cd6916a7"

      def install
        bin.install "ud_0.34.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.0/ud_0.34.0_linux_amd64.tar.gz"
      sha256 "5d17461c36d3805778222bd843e24fd74830af542c580fa3e61e7539bb38f293"

      def install
        bin.install "ud_0.34.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.0", shell_output("#{bin}/ud --version")
  end
end
