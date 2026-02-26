class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.5/ud_0.34.5_darwin_arm64.tar.gz"
      sha256 "3c3f338d0cff947b90ce773aca1e7a50fddc643a804e635b873a65e95d8d1eb9"

      def install
        bin.install "ud_0.34.5_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.5/ud_0.34.5_darwin_amd64.tar.gz"
      sha256 "d1ec1f6977ef1e2ce09d411f6124968d72b925652ee3cb5442e19e804943fe3e"

      def install
        bin.install "ud_0.34.5_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.5/ud_0.34.5_linux_arm64.tar.gz"
      sha256 "5652f1ce4370fda3a2c15e3961b128584bdf6bc1ffc338402602307da1a8030f"

      def install
        bin.install "ud_0.34.5_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.5/ud_0.34.5_linux_amd64.tar.gz"
      sha256 "d4212d1a2d92e1716d80e720e2be4403cc6876ca219bc7a790fb13a6da4ddc9e"

      def install
        bin.install "ud_0.34.5_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.5", shell_output("#{bin}/ud --version")
  end
end
