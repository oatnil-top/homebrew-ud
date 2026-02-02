class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.11/ud_0.21.11_darwin_arm64.tar.gz"
      sha256 "8581e1e135f2ec3538db31fb26b34d675f242830a34f6899f34a70673da927a6"

      def install
        bin.install "ud_0.21.11_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.11/ud_0.21.11_darwin_amd64.tar.gz"
      sha256 "5e6f8d82fe83b6516f1a59c8ea2e0226d25b0bc77ee502e0f7b9a31a90001863"

      def install
        bin.install "ud_0.21.11_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.11/ud_0.21.11_linux_arm64.tar.gz"
      sha256 "c9efbd3671871c4b63b4cf9fbe754578928f9d7d9eeab01360249a4b5f829481"

      def install
        bin.install "ud_0.21.11_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.11/ud_0.21.11_linux_amd64.tar.gz"
      sha256 "191479b3598a4266fb098a8a60ea7254607f1cb83b6271cd9669074149dc08e1"

      def install
        bin.install "ud_0.21.11_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.11", shell_output("#{bin}/ud --version")
  end
end
