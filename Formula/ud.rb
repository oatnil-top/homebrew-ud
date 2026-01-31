class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.5/ud_0.21.5_darwin_arm64.tar.gz"
      sha256 "466d196112ae67a83d6fe4d14687a507925ba698d34afb6da2d6e8009e402074"

      def install
        bin.install "ud_0.21.5_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.5/ud_0.21.5_darwin_amd64.tar.gz"
      sha256 "2a17128c083fe0e49e49ae821ad20e560cf97e3717fee78c348220397faab123"

      def install
        bin.install "ud_0.21.5_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.5/ud_0.21.5_linux_arm64.tar.gz"
      sha256 "72aa6270420e6e716e3746e4b33bd31d1763241f8772bfea1e000759e9b87f56"

      def install
        bin.install "ud_0.21.5_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.5/ud_0.21.5_linux_amd64.tar.gz"
      sha256 "90a08faad0930f7f67964be90f6f0af51f7b8961f34f3a88e0ad5cf990de24e5"

      def install
        bin.install "ud_0.21.5_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.5", shell_output("#{bin}/ud --version")
  end
end
