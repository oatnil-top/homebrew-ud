class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.27.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.0/ud_0.27.0_darwin_arm64.tar.gz"
      sha256 "c20690393f317bd6a050e34742ad1cf899f6a2d6a873b85da2b709787f31997e"

      def install
        bin.install "ud_0.27.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.0/ud_0.27.0_darwin_amd64.tar.gz"
      sha256 "5930d02d95be10a2e446bd5dc9d560590a39e2fcf5258a3b461811e86a203b25"

      def install
        bin.install "ud_0.27.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.0/ud_0.27.0_linux_arm64.tar.gz"
      sha256 "ab4f1eec46afddce1fe6cc51bdbfb708997f10e9c799c2a27951f035c949666e"

      def install
        bin.install "ud_0.27.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.0/ud_0.27.0_linux_amd64.tar.gz"
      sha256 "47904f836219261cbb99b3f619a62a1ae7b2d8e9fe99923bfc4c5a71124cfdc7"

      def install
        bin.install "ud_0.27.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.27.0", shell_output("#{bin}/ud --version")
  end
end
