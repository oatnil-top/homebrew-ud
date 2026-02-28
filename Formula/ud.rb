class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.1/ud_0.35.1_darwin_arm64.tar.gz"
      sha256 "c5f2f776347937769460375ab32a3bf3c2f48e17ae1f6b88446d0c206880b3b4"

      def install
        bin.install "ud_0.35.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.1/ud_0.35.1_darwin_amd64.tar.gz"
      sha256 "9bdbeb0966fcf77ebce1862f73b67a1c0873b8d36a8cb3e44d264f5b3a4d3022"

      def install
        bin.install "ud_0.35.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.1/ud_0.35.1_linux_arm64.tar.gz"
      sha256 "f18728b44030aa678d065b1141ec8eaea0267c81b0c14cbd067b0bf1444fabb6"

      def install
        bin.install "ud_0.35.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.1/ud_0.35.1_linux_amd64.tar.gz"
      sha256 "84cd82ef60e303d2ea67b9d199ffa137d16ed20859a924d7b769d2af7b0b1461"

      def install
        bin.install "ud_0.35.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.1", shell_output("#{bin}/ud --version")
  end
end
