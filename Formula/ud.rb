class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.4/ud_0.25.4_darwin_arm64.tar.gz"
      sha256 "f94878c73f9cdb051b23e5cd31eaa454d9a10c9bf5afbab2cdcf2d4d6280dc31"

      def install
        bin.install "ud_0.25.4_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.4/ud_0.25.4_darwin_amd64.tar.gz"
      sha256 "6681e98ad20ef8e95510b27975c6bb1818e304956bc16e2e8fbdafbe096b71b3"

      def install
        bin.install "ud_0.25.4_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.4/ud_0.25.4_linux_arm64.tar.gz"
      sha256 "27fb816845aa52bc8f5dd3bfe15dca016247b5b4c2f9d69b5b4337e34575e4f4"

      def install
        bin.install "ud_0.25.4_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.4/ud_0.25.4_linux_amd64.tar.gz"
      sha256 "7ec275cc559e6ddb4970725973f1f6a60b8b09f4aee057920a3afff72531ac4e"

      def install
        bin.install "ud_0.25.4_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.4", shell_output("#{bin}/ud --version")
  end
end
