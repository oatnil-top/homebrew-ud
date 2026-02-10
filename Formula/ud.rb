class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.26.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.26.0/ud_0.26.0_darwin_arm64.tar.gz"
      sha256 "2c89ac2a6574b1f6be34ff11db4fa8123ae7c21ac868613bfd19ad9929c3af2d"

      def install
        bin.install "ud_0.26.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.26.0/ud_0.26.0_darwin_amd64.tar.gz"
      sha256 "100b2edfa424ca88a534aa58c2e9c2a5b291a741f1c61c86ccaff70223b8614a"

      def install
        bin.install "ud_0.26.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.26.0/ud_0.26.0_linux_arm64.tar.gz"
      sha256 "b92baeae419391e5afc1646a77bc84a6358ceddbdc51f60cacb65a9db2033278"

      def install
        bin.install "ud_0.26.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.26.0/ud_0.26.0_linux_amd64.tar.gz"
      sha256 "6907a05969fb7178e94bb47fffb7011d7a6cc600ed7d472085e61e056d61e537"

      def install
        bin.install "ud_0.26.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.26.0", shell_output("#{bin}/ud --version")
  end
end
