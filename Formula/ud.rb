class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.2/ud_0.35.2_darwin_arm64.tar.gz"
      sha256 "eb74fff963824c32a27eae2c197b587cb561b4fbcbce757ecae08893ec89d80e"

      def install
        bin.install "ud_0.35.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.2/ud_0.35.2_darwin_amd64.tar.gz"
      sha256 "d73172f7e10c05683ff8e834d389a1987143c8c2a759063a71cd68eaadd3dd80"

      def install
        bin.install "ud_0.35.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.2/ud_0.35.2_linux_arm64.tar.gz"
      sha256 "3b18b55ad27ccb8863cc3f5eef16dbd91e0c2288213a073b17177ff4696b1cef"

      def install
        bin.install "ud_0.35.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.2/ud_0.35.2_linux_amd64.tar.gz"
      sha256 "6762ccde6d812cf22bf0dc7b444c8af95b4ecd0614373fe5b92144dab12a3814"

      def install
        bin.install "ud_0.35.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.2", shell_output("#{bin}/ud --version")
  end
end
