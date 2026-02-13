class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.29.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.0/ud_0.29.0_darwin_arm64.tar.gz"
      sha256 "e95cf16c9721f5b9085cc5931bf24b314def324964cba12d4afefc2291e5f5e4"

      def install
        bin.install "ud_0.29.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.0/ud_0.29.0_darwin_amd64.tar.gz"
      sha256 "a3c9875faa2d224983839e1d85664452cc92e076e446ffb98bfe785b7086c4cb"

      def install
        bin.install "ud_0.29.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.0/ud_0.29.0_linux_arm64.tar.gz"
      sha256 "676abb2b34e3881949ceaec5810973447834f389bb7be8f4641ea41a4b375fd8"

      def install
        bin.install "ud_0.29.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.0/ud_0.29.0_linux_amd64.tar.gz"
      sha256 "dda7f4cb452cfa880b35d16ff74f796d4bf63cf87b45c07e1a82df7c714c58c7"

      def install
        bin.install "ud_0.29.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.29.0", shell_output("#{bin}/ud --version")
  end
end
