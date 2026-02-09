class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.5/ud_0.25.5_darwin_arm64.tar.gz"
      sha256 "977dc1899f60047079305986d451c490e77cf012780b3af853455b0b223c10af"

      def install
        bin.install "ud_0.25.5_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.5/ud_0.25.5_darwin_amd64.tar.gz"
      sha256 "8bd31e8ff04e8ebfcd2e5ea9beaadcbb8dde5347cf4f566a35d38538a1b445be"

      def install
        bin.install "ud_0.25.5_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.5/ud_0.25.5_linux_arm64.tar.gz"
      sha256 "9b027abf3a2c8515e6334056d4895b47d39cc9c487778791ad879d78e7d671cf"

      def install
        bin.install "ud_0.25.5_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.5/ud_0.25.5_linux_amd64.tar.gz"
      sha256 "defc599f8def20023d9fe2a3d7ba02b7dcef66ff86d6ae26428254f675afff91"

      def install
        bin.install "ud_0.25.5_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.5", shell_output("#{bin}/ud --version")
  end
end
