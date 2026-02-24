class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.1/ud_0.34.1_darwin_arm64.tar.gz"
      sha256 "311a34a2b6b1ef7734facd5727a517b2641674cedecb237d3862ace57f1e9362"

      def install
        bin.install "ud_0.34.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.1/ud_0.34.1_darwin_amd64.tar.gz"
      sha256 "4fc401c73f1f9f78f56a3e720622a49105a4700916bb4a133cc477c42dfdec62"

      def install
        bin.install "ud_0.34.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.1/ud_0.34.1_linux_arm64.tar.gz"
      sha256 "5c3248f835b7e2143bc491e8c7b8b3f9f95a9d6b37d89e6666127a0596c14740"

      def install
        bin.install "ud_0.34.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.1/ud_0.34.1_linux_amd64.tar.gz"
      sha256 "2ed77d66922a26ef5957ff893705b381ee4c9e1bd77fe67156cdacc31dcd4b19"

      def install
        bin.install "ud_0.34.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.1", shell_output("#{bin}/ud --version")
  end
end
