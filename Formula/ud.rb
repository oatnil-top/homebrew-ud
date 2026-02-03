class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.22.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.2/ud_0.22.2_darwin_arm64.tar.gz"
      sha256 "7ea4c09296cd949c022fdeb994bb16147f42d3c3f80daa9e496e642166d15dd6"

      def install
        bin.install "ud_0.22.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.2/ud_0.22.2_darwin_amd64.tar.gz"
      sha256 "1905cdf0fb1ec20295e8d80562d0d0b8baa57c9909463519224b1c644a26877d"

      def install
        bin.install "ud_0.22.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.2/ud_0.22.2_linux_arm64.tar.gz"
      sha256 "a2b5eb45cd9a7e361ceb052c88d020fb50e53899fcf6a4b84b19b7634b198a2d"

      def install
        bin.install "ud_0.22.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.2/ud_0.22.2_linux_amd64.tar.gz"
      sha256 "a99b5692bc5d84ce0eb53a55891614973b3ef8f34a1b310d48528a69bda414ea"

      def install
        bin.install "ud_0.22.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.22.2", shell_output("#{bin}/ud --version")
  end
end
