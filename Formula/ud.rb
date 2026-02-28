class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.3/ud_0.35.3_darwin_arm64.tar.gz"
      sha256 "2eaa677fc7686bb1af3248029e1863f4c0e2ab48be09a1ff56dedca5943a5f6b"

      def install
        bin.install "ud_0.35.3_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.3/ud_0.35.3_darwin_amd64.tar.gz"
      sha256 "924749ca054924e6894466c5948321d9ff64799c179a79cf64e1f5f61e6dc781"

      def install
        bin.install "ud_0.35.3_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.3/ud_0.35.3_linux_arm64.tar.gz"
      sha256 "e40e83bea4bbb4b95f54706027927ea3144c82e4562ef86517821cb2c0787427"

      def install
        bin.install "ud_0.35.3_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.3/ud_0.35.3_linux_amd64.tar.gz"
      sha256 "ede675fc6a8a81dfeaa7c38f946f5cff56a6d339dd7b6aeaa0a1f159a1aaa71e"

      def install
        bin.install "ud_0.35.3_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.3", shell_output("#{bin}/ud --version")
  end
end
