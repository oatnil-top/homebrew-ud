class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.6/ud_0.34.6_darwin_arm64.tar.gz"
      sha256 "30f1229e8fe114b567f798ba9910076209f8d36f32df76614fddf3d4a48b4a4e"

      def install
        bin.install "ud_0.34.6_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.6/ud_0.34.6_darwin_amd64.tar.gz"
      sha256 "af8337e205507eb9b4be9faef42fd4da7cddd7bdd2c3eb0cd7c552b7bfc9319a"

      def install
        bin.install "ud_0.34.6_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.6/ud_0.34.6_linux_arm64.tar.gz"
      sha256 "59ba108b81c5cf439c10fef1b82899cdf3e5b6c2168dfe4d9349431d7ea1317f"

      def install
        bin.install "ud_0.34.6_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.6/ud_0.34.6_linux_amd64.tar.gz"
      sha256 "796d913994a14b8bfcf3cf741812aaf394e7e8d82882793a8d9032af5cf697df"

      def install
        bin.install "ud_0.34.6_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.6", shell_output("#{bin}/ud --version")
  end
end
