class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.33.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_darwin_arm64.tar.gz"
      sha256 "b9af6e2a00069220a00bbb19b6d87255b31a1fd7a33b75d56b38596b3209a464"

      def install
        bin.install "ud_0.33.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_darwin_amd64.tar.gz"
      sha256 "41f770574a7fd493a2b8d9ccba08ca0dcc063277f495d9329f600e0a9b217546"

      def install
        bin.install "ud_0.33.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_linux_arm64.tar.gz"
      sha256 "0ef1d0293d5038b166e053a5ea10903f4ed87a33314c316e1626a3ffb3bae1dd"

      def install
        bin.install "ud_0.33.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_linux_amd64.tar.gz"
      sha256 "d72e78980242d3bb1ce3b81c40f9d51d46ef4808785ea2515662707f8ebee80b"

      def install
        bin.install "ud_0.33.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.33.1", shell_output("#{bin}/ud --version")
  end
end
