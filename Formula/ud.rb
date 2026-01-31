class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.6/ud_0.21.6_darwin_arm64.tar.gz"
      sha256 "e39b84a49451ad5ebed11d397adc93c73792e1ed9a3435a6a54ba1540c94d204"

      def install
        bin.install "ud_0.21.6_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.6/ud_0.21.6_darwin_amd64.tar.gz"
      sha256 "c84b05f12afc78901499eb7955508d46ffbc7b7cc66c3a13c649fe6db8a98059"

      def install
        bin.install "ud_0.21.6_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.6/ud_0.21.6_linux_arm64.tar.gz"
      sha256 "c7e7e2f9baa19101211d2c0c6e45433c8a91780eef5e696c4f04d57f58b120fe"

      def install
        bin.install "ud_0.21.6_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.6/ud_0.21.6_linux_amd64.tar.gz"
      sha256 "74199fed048c8e248aeaadfa6932eb018644cc6b585435c3ef4bffa87fb5257f"

      def install
        bin.install "ud_0.21.6_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.6", shell_output("#{bin}/ud --version")
  end
end
