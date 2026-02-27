class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.7/ud_0.34.7_darwin_arm64.tar.gz"
      sha256 "5ea33c5666f1780e58016227d7b619ff35c4c62b31d95cc24b9fad03eb3fd932"

      def install
        bin.install "ud_0.34.7_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.7/ud_0.34.7_darwin_amd64.tar.gz"
      sha256 "58a66a1ce1850d5af118b1f97c44ddd9a057553525a55bcbed91cc7db48296d8"

      def install
        bin.install "ud_0.34.7_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.7/ud_0.34.7_linux_arm64.tar.gz"
      sha256 "d4d96c6768bfb3917aa870a7be33ef91512a49bbc1673ca2761649d078fac079"

      def install
        bin.install "ud_0.34.7_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.7/ud_0.34.7_linux_amd64.tar.gz"
      sha256 "37f650044d3de5f0c6f6c6eab65546d386603fe59f4c3f979c27d079c1bd628e"

      def install
        bin.install "ud_0.34.7_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.7", shell_output("#{bin}/ud --version")
  end
end
