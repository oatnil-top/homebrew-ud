class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.9/ud_0.21.9_darwin_arm64.tar.gz"
      sha256 "8f66e8be35f1d52df7d36db7e4a14aadfb8946383dc5fd1b64668c8967737c55"

      def install
        bin.install "ud_0.21.9_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.9/ud_0.21.9_darwin_amd64.tar.gz"
      sha256 "f60192ebb1a658116f99c85055fb72561315ba32fe5547142636a621d0c2fd18"

      def install
        bin.install "ud_0.21.9_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.9/ud_0.21.9_linux_arm64.tar.gz"
      sha256 "dd87abd57e349cd15d1cf4a19a640cc1edee0ab3c34d1b264a31257a584156a9"

      def install
        bin.install "ud_0.21.9_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.9/ud_0.21.9_linux_amd64.tar.gz"
      sha256 "529dc0aa5db8ccc3fa39fd022b44a6560da4344a79a9bcf17e8b96540aa16cae"

      def install
        bin.install "ud_0.21.9_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.9", shell_output("#{bin}/ud --version")
  end
end
