class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.3/ud_0.25.3_darwin_arm64.tar.gz"
      sha256 "3f2e8ecf8a11985ae00affe33f7d189d2ab5097569083f72ba1744e7d5b2807c"

      def install
        bin.install "ud_0.25.3_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.3/ud_0.25.3_darwin_amd64.tar.gz"
      sha256 "b7b0a8e6213790586a20346e2cdb6ec12915fa906d47c134cec23b2988650e89"

      def install
        bin.install "ud_0.25.3_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.3/ud_0.25.3_linux_arm64.tar.gz"
      sha256 "8db80fe0b6f546de4b66ece02cd118a9e6d8be88f9e1d693a1fa7de0c4382c89"

      def install
        bin.install "ud_0.25.3_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.3/ud_0.25.3_linux_amd64.tar.gz"
      sha256 "dfed681585831c75cf49e7404274e83967db93ed84fa1fd34ece1dc0185451d0"

      def install
        bin.install "ud_0.25.3_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.3", shell_output("#{bin}/ud --version")
  end
end
