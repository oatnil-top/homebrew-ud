class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.29.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.1/ud_0.29.1_darwin_arm64.tar.gz"
      sha256 "f6722305819080f64fed6a5d26f1683e505f6fd943bb9697260dbe7f6bd222c4"

      def install
        bin.install "ud_0.29.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.1/ud_0.29.1_darwin_amd64.tar.gz"
      sha256 "d127f882265b9fea1ea47b7be4b6035462b0bce16bd4a59e9063b1933e58cb84"

      def install
        bin.install "ud_0.29.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.1/ud_0.29.1_linux_arm64.tar.gz"
      sha256 "4a2f65c975427780ea9a0cb90703683f82bcc55a2dc24753f7dde469b5811310"

      def install
        bin.install "ud_0.29.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.29.1/ud_0.29.1_linux_amd64.tar.gz"
      sha256 "7341fb71d7252f3ce20faa349770a30874bd6b23cf3bcb7d4dfee7866f34c641"

      def install
        bin.install "ud_0.29.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.29.1", shell_output("#{bin}/ud --version")
  end
end
