class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.30.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.1/ud_0.30.1_darwin_arm64.tar.gz"
      sha256 "00fb18254ad80f1f1dcf952905c4869aabdf9c0da618d8fa6b841633b68f9e75"

      def install
        bin.install "ud_0.30.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.1/ud_0.30.1_darwin_amd64.tar.gz"
      sha256 "1d5208bbac50ac5747e8d6658def84b3ed4e4cce48decc247c9d3507798f1068"

      def install
        bin.install "ud_0.30.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.1/ud_0.30.1_linux_arm64.tar.gz"
      sha256 "f33a02a87bd11ac2331fe35bd191005083f82c211b614ba5de98270b6ec46358"

      def install
        bin.install "ud_0.30.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.1/ud_0.30.1_linux_amd64.tar.gz"
      sha256 "1c37006a459fa758391f4223ab796f564dc1e42d264d3d39435f41b794b18a1a"

      def install
        bin.install "ud_0.30.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.30.1", shell_output("#{bin}/ud --version")
  end
end
