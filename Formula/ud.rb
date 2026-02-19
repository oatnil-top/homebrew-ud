class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.33.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.0/ud_0.33.0_darwin_arm64.tar.gz"
      sha256 "d389262234a34e3edfba83edbec95094e4a03677721f8a9daa1650c7929c27f7"

      def install
        bin.install "ud_0.33.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.0/ud_0.33.0_darwin_amd64.tar.gz"
      sha256 "a58a499162d4e6293bea3c6d31d3779c605af98942aee633a20536b05be1f0cc"

      def install
        bin.install "ud_0.33.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.0/ud_0.33.0_linux_arm64.tar.gz"
      sha256 "e69ed25596602440480215d60ae83c7e61f467059a93f15ac7b261973ed25847"

      def install
        bin.install "ud_0.33.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.0/ud_0.33.0_linux_amd64.tar.gz"
      sha256 "11b683b55087fc776f687dbb59d6a48f9643b0484f32a976c3d01d82d81aa5e9"

      def install
        bin.install "ud_0.33.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.33.0", shell_output("#{bin}/ud --version")
  end
end
