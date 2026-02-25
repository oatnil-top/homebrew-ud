class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.3/ud_0.34.3_darwin_arm64.tar.gz"
      sha256 "3f592a9a928981ea89bee9743a2b4ee45abd07218f3033aa333cdc2a23d43e4c"

      def install
        bin.install "ud_0.34.3_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.3/ud_0.34.3_darwin_amd64.tar.gz"
      sha256 "36b0384fa77ad1bde07f74a2143172522ad5b0be3446df07bec7c99d79481131"

      def install
        bin.install "ud_0.34.3_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.3/ud_0.34.3_linux_arm64.tar.gz"
      sha256 "4050d204b6df324c8f042198d6764c29fb642847a873b1d6ef6be95e1c121c60"

      def install
        bin.install "ud_0.34.3_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.3/ud_0.34.3_linux_amd64.tar.gz"
      sha256 "de8edd6928e5a079fb6efec5b43a06f5bdead0248e19414ab495baca8705779e"

      def install
        bin.install "ud_0.34.3_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.3", shell_output("#{bin}/ud --version")
  end
end
