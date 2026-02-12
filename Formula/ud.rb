class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.5/ud_0.28.5_darwin_arm64.tar.gz"
      sha256 "c27d7186527e67983f6f9559ede555bdb56c9a8bb65a5db20bd6f88af5a24050"

      def install
        bin.install "ud_0.28.5_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.5/ud_0.28.5_darwin_amd64.tar.gz"
      sha256 "5c89c350bb9fe47104af464fadc4298de06cdc8798aeaafd58892b1103fd9b4e"

      def install
        bin.install "ud_0.28.5_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.5/ud_0.28.5_linux_arm64.tar.gz"
      sha256 "a6323179cf0f376507b31955a789481758baec623803b0c764dc2040e4cf1734"

      def install
        bin.install "ud_0.28.5_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.5/ud_0.28.5_linux_amd64.tar.gz"
      sha256 "e5dfb26be2e0c31524ba2bf51f06af5d5fad72b7ae152be4d679673c57c3fe8c"

      def install
        bin.install "ud_0.28.5_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.5", shell_output("#{bin}/ud --version")
  end
end
