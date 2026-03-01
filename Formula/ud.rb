class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.5/ud_0.35.5_darwin_arm64.tar.gz"
      sha256 "05c641a14c6abad3acd9f6161b18ac1ce32cafc9a5d5a52359094d7ce5e480b1"

      def install
        bin.install "ud_0.35.5_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.5/ud_0.35.5_darwin_amd64.tar.gz"
      sha256 "3f8c3cff2a265c573d22317312bb022b1d579e10fb2f2acf84ef4b76ebad3a0c"

      def install
        bin.install "ud_0.35.5_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.5/ud_0.35.5_linux_arm64.tar.gz"
      sha256 "d36a45046f1cbea758d2a4336a4831c35683645e5ce1d791f2d57334fe89d996"

      def install
        bin.install "ud_0.35.5_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.5/ud_0.35.5_linux_amd64.tar.gz"
      sha256 "59a0e3539681296adb47836a40d69580135dbea4f023a281972c014dea510d67"

      def install
        bin.install "ud_0.35.5_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.5", shell_output("#{bin}/ud --version")
  end
end
