class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.8/ud_0.21.8_darwin_arm64.tar.gz"
      sha256 "bce493180b346db40221b42e1e1ef50d98a4f5d29f857c4101d63c51c9544a45"

      def install
        bin.install "ud_0.21.8_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.8/ud_0.21.8_darwin_amd64.tar.gz"
      sha256 "b819c7af67b2629b0a6fcb87d00dca81391e5c5a3b2196518308c461f2bc7dd2"

      def install
        bin.install "ud_0.21.8_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.8/ud_0.21.8_linux_arm64.tar.gz"
      sha256 "ba425c62f36ae679a8ce5cc2487364e0a008bcbcd0b0aa95d9db81d88ce2d60b"

      def install
        bin.install "ud_0.21.8_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.8/ud_0.21.8_linux_amd64.tar.gz"
      sha256 "cd0b9ed9874728a91acb34798d9af97469978daad725103213d5d5ab1e69a0b6"

      def install
        bin.install "ud_0.21.8_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.8", shell_output("#{bin}/ud --version")
  end
end
