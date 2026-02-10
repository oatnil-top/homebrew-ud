class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.27.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.1/ud_0.27.1_darwin_arm64.tar.gz"
      sha256 "c77882e90d46d4e134fe75e2dc7fce489b58286ab239f0320528e5ba4f6509a5"

      def install
        bin.install "ud_0.27.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.1/ud_0.27.1_darwin_amd64.tar.gz"
      sha256 "0385afad7947acdc70fcf268958c928d941bf45ade92d33e2437ec904b0869d1"

      def install
        bin.install "ud_0.27.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.1/ud_0.27.1_linux_arm64.tar.gz"
      sha256 "0cad702607ec83c2449cace4124b857d44864ee40bd697b25c5569b42514f812"

      def install
        bin.install "ud_0.27.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.1/ud_0.27.1_linux_amd64.tar.gz"
      sha256 "b46150f47b3daa907c0daeb9f1c78e518ccd92f096a7a3f58b2aca30b52ca21e"

      def install
        bin.install "ud_0.27.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.27.1", shell_output("#{bin}/ud --version")
  end
end
