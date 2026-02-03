class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.22.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.1/ud_0.22.1_darwin_arm64.tar.gz"
      sha256 "acf062a3c1b97a04b7a5cbbc8b8c72a7bfc6bf873a425f5edb16e4bdda29a30b"

      def install
        bin.install "ud_0.22.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.1/ud_0.22.1_darwin_amd64.tar.gz"
      sha256 "053a8488b0e35916e0f031dfab24e00d97b151b63754978f1764a270a99db939"

      def install
        bin.install "ud_0.22.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.1/ud_0.22.1_linux_arm64.tar.gz"
      sha256 "eca4b8c77a214e787fcb384e2d6a7271c33bd2ca8a90df7a9b63743a291b56b4"

      def install
        bin.install "ud_0.22.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.1/ud_0.22.1_linux_amd64.tar.gz"
      sha256 "808eb49f6c6c2e28c101e9f6d7f0c70fef13750af3d33db865d36b799c2ded16"

      def install
        bin.install "ud_0.22.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.22.1", shell_output("#{bin}/ud --version")
  end
end
