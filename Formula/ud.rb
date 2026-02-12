class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.3/ud_0.28.3_darwin_arm64.tar.gz"
      sha256 "8e3be1b46d150b7151369e1e531fcc4c01f0682201a0a928ba1afff33bbc40f9"

      def install
        bin.install "ud_0.28.3_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.3/ud_0.28.3_darwin_amd64.tar.gz"
      sha256 "bbd0f2368afe9c9419ffbcbd949fccc28cd06d5ec1e4494a87634ef53ccaad80"

      def install
        bin.install "ud_0.28.3_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.3/ud_0.28.3_linux_arm64.tar.gz"
      sha256 "e035276562b35a9955d4f98a804a56b6ae8d5318e524f27fc036d5c55955a0a6"

      def install
        bin.install "ud_0.28.3_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.3/ud_0.28.3_linux_amd64.tar.gz"
      sha256 "d20f1408ce36df25624283abef321359ed81fe403cc6c93a8e76c62d013e5476"

      def install
        bin.install "ud_0.28.3_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.3", shell_output("#{bin}/ud --version")
  end
end
