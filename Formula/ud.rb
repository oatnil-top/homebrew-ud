class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.0/ud_0.28.0_darwin_arm64.tar.gz"
      sha256 "904682762610d31823ba5958b001413937a685c16a5a0c76f066a3741916ba9d"

      def install
        bin.install "ud_0.28.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.0/ud_0.28.0_darwin_amd64.tar.gz"
      sha256 "071f8089411f826dd7358215805778f68c45ddd85153d647bd168e3e891fe73b"

      def install
        bin.install "ud_0.28.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.0/ud_0.28.0_linux_arm64.tar.gz"
      sha256 "a1a3f1ee10429fdbb84cd28b947803f952e5764d883ab2989201541aa6c5618e"

      def install
        bin.install "ud_0.28.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.0/ud_0.28.0_linux_amd64.tar.gz"
      sha256 "fbbd38ce83e3c5982f1cf8d3e1e27cd51f8037391fbec186205db60dba3443c7"

      def install
        bin.install "ud_0.28.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.0", shell_output("#{bin}/ud --version")
  end
end
