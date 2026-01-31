class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.4/ud_0.21.4_darwin_arm64.tar.gz"
      sha256 "7feced63df72efd4f44dd962cbe0d1c2a98d260e219ed2ced6a0b301c11d67c4"

      def install
        bin.install "ud_0.21.4_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.4/ud_0.21.4_darwin_amd64.tar.gz"
      sha256 "e11b7f5deae1f265faf1bdcfbeb285d6151fcf103c82e9ae109a52c1a24182e1"

      def install
        bin.install "ud_0.21.4_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.4/ud_0.21.4_linux_arm64.tar.gz"
      sha256 "dbcc7bb11bc8360ef1d6fb1b0a856444f7f203708cd19be8a438238a2a7ae2fd"

      def install
        bin.install "ud_0.21.4_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.4/ud_0.21.4_linux_amd64.tar.gz"
      sha256 "2ccbcf6e6cc61a7934121d47566c5678248a3e63495e2d93e634c34be4da7aed"

      def install
        bin.install "ud_0.21.4_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.4", shell_output("#{bin}/ud --version")
  end
end
