class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.7/ud_0.35.7_darwin_arm64.tar.gz"
      sha256 "a924eafd55f092ce473eaf78a2e8da65c955437592400ed1142469152b5287a1"

      def install
        bin.install "ud_0.35.7_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.7/ud_0.35.7_darwin_amd64.tar.gz"
      sha256 "d0bf5c703e04c9e6cb9507d915dee2a1c806e24b759a86f6789798b7be237076"

      def install
        bin.install "ud_0.35.7_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.7/ud_0.35.7_linux_arm64.tar.gz"
      sha256 "8ecb7e0b501be4f0c7b6dd95a7e4f92b9deda154f6e195b19dabc4e6fc2d3099"

      def install
        bin.install "ud_0.35.7_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.7/ud_0.35.7_linux_amd64.tar.gz"
      sha256 "97c1eeb61e7aa9b70ec144815d9f1d0a65673eb79dc6f0e054209d57b1d6f9a1"

      def install
        bin.install "ud_0.35.7_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.7", shell_output("#{bin}/ud --version")
  end
end
