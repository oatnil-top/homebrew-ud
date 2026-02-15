class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.31.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.1/ud_0.31.1_darwin_arm64.tar.gz"
      sha256 "cb0a5e0a7d0af2dd49be58397c7f39b350d49557bd8eb6183b9ffb82c5516f61"

      def install
        bin.install "ud_0.31.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.1/ud_0.31.1_darwin_amd64.tar.gz"
      sha256 "6a466eaf22473fd35eb2e88cccac70bdeaa07c236f2c8c12b957da1b42e0cd48"

      def install
        bin.install "ud_0.31.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.1/ud_0.31.1_linux_arm64.tar.gz"
      sha256 "2ade9afbee6b603ec1f8ecc6def6c3d39ce528a4060c2e36113c956e2d381602"

      def install
        bin.install "ud_0.31.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.31.1/ud_0.31.1_linux_amd64.tar.gz"
      sha256 "6b98139fc59312c2fe18df6d5233515a90cc968f845413dff367a9419f591c76"

      def install
        bin.install "ud_0.31.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.31.1", shell_output("#{bin}/ud --version")
  end
end
