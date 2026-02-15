class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.31.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.0/ud_0.31.0_darwin_arm64.tar.gz"
      sha256 "ed64193e3fe96e11629530bac7398417d44ce7a78a76f4720a3e81ee333669a5"

      def install
        bin.install "ud_0.31.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.0/ud_0.31.0_darwin_amd64.tar.gz"
      sha256 "4d7f023bd75c609f3df76fa985054f71b277cb59b5d35c1d87eda5a9a424c08d"

      def install
        bin.install "ud_0.31.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.0/ud_0.31.0_linux_arm64.tar.gz"
      sha256 "be43696e6469a3620989f596b848d47c830829d45c2a06866cca78839a2bd127"

      def install
        bin.install "ud_0.31.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.0/ud_0.31.0_linux_amd64.tar.gz"
      sha256 "1eace88f43e3c524926f0e7a7784f69c0c5dac7ef00b4db0536725a754efec0a"

      def install
        bin.install "ud_0.31.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.31.0", shell_output("#{bin}/ud --version")
  end
end
