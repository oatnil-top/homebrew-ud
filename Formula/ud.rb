class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.24.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.24.0/ud_0.24.0_darwin_arm64.tar.gz"
      sha256 "3433b7fb7b529b6025dbc95d10ec38c026f863f4bf3b11b0f33400ac48b2c34f"

      def install
        bin.install "ud_0.24.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.24.0/ud_0.24.0_darwin_amd64.tar.gz"
      sha256 "9369a9c0d9a398599ac74b9cca0f00214d7cf97a7cbcd76b3da79e9b11da691a"

      def install
        bin.install "ud_0.24.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.24.0/ud_0.24.0_linux_arm64.tar.gz"
      sha256 "7dc80b26121a152e10c9e5da4f7817b7233f4e2f96bcc8a62b6d092e6d0a4f3d"

      def install
        bin.install "ud_0.24.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.24.0/ud_0.24.0_linux_amd64.tar.gz"
      sha256 "45880d6d82ce9ce323cfb684128f3a5fdb20f02abb9d859c1970560c2699b903"

      def install
        bin.install "ud_0.24.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.24.0", shell_output("#{bin}/ud --version")
  end
end
