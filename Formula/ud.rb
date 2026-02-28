class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.4/ud_0.35.4_darwin_arm64.tar.gz"
      sha256 "89aacac21b21805c9b0d7dc29031e28f3054281ff923ab05c9be510acf5072bc"

      def install
        bin.install "ud_0.35.4_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.4/ud_0.35.4_darwin_amd64.tar.gz"
      sha256 "365c51ac86e11a0932ff016489d9dd40ffe2a3b318c575deb47f233f44d96d0c"

      def install
        bin.install "ud_0.35.4_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.4/ud_0.35.4_linux_arm64.tar.gz"
      sha256 "6e17cb9b8632591b260b79c8c6152c95d65799de092c52ef3e1a44b9b6e1e682"

      def install
        bin.install "ud_0.35.4_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.4/ud_0.35.4_linux_amd64.tar.gz"
      sha256 "03b3f5bb9d559d0ce48f6d00daa34d639ab2d55875ce743fc6620366a585fa60"

      def install
        bin.install "ud_0.35.4_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.4", shell_output("#{bin}/ud --version")
  end
end
