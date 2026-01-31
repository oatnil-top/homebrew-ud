class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.7/ud_0.21.7_darwin_arm64.tar.gz"
      sha256 "6429fa4b19b066a66e43d91645d3fb63494ec19da3a495c53fb4a9c1dd626bba"

      def install
        bin.install "ud_0.21.7_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.7/ud_0.21.7_darwin_amd64.tar.gz"
      sha256 "e0b8bdbcc1fe4bc4eba4a22794df2104dbe76f86da214413a29f7e69369e53c9"

      def install
        bin.install "ud_0.21.7_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.7/ud_0.21.7_linux_arm64.tar.gz"
      sha256 "ec81420265440e2d50d51eed6d8bd427ae9231ff881b0438c3f6888fb4673e32"

      def install
        bin.install "ud_0.21.7_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.7/ud_0.21.7_linux_amd64.tar.gz"
      sha256 "5f2050bdc4313e7b8a1bb54204f549041af57aa0bb9c257890b668ea961034c9"

      def install
        bin.install "ud_0.21.7_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.7", shell_output("#{bin}/ud --version")
  end
end
