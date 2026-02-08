class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.2/ud_0.25.2_darwin_arm64.tar.gz"
      sha256 "deb3772d277991e8ff2988efc48f86bbd448de5839911e2dc347113f9cd65c89"

      def install
        bin.install "ud_0.25.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.2/ud_0.25.2_darwin_amd64.tar.gz"
      sha256 "28ba90d410340b6a944baccc34eba4353d5c6096569a99423538fdce04c3cd1c"

      def install
        bin.install "ud_0.25.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.2/ud_0.25.2_linux_arm64.tar.gz"
      sha256 "8eec33429083c5208c7e7904be460690e631305f7cc5aed3d6eeef085f9ea402"

      def install
        bin.install "ud_0.25.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.2/ud_0.25.2_linux_amd64.tar.gz"
      sha256 "82b62dee2c1e79e7a19e9573646087f05a58b6ac299b0b4bddd3c34a627f3a56"

      def install
        bin.install "ud_0.25.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.2", shell_output("#{bin}/ud --version")
  end
end
