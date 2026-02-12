class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.1/ud_0.28.1_darwin_arm64.tar.gz"
      sha256 "3540d75a8895bf36c174f205ca1be65262f14a9b5cc67009f1b79bcddae5c367"

      def install
        bin.install "ud_0.28.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.1/ud_0.28.1_darwin_amd64.tar.gz"
      sha256 "27d95d84ded497be49e4f0561c0d177660d4171ada2699b97fd809a8f9052ff7"

      def install
        bin.install "ud_0.28.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.1/ud_0.28.1_linux_arm64.tar.gz"
      sha256 "f71fdcb0b75e598e3f976981f9114684a46788bd96fbae5f2ee8edaddb375222"

      def install
        bin.install "ud_0.28.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.1/ud_0.28.1_linux_amd64.tar.gz"
      sha256 "5136ca9404f7a25f2f9f8466a9c9e735f137864ccaacffb8e5e36b34731353dd"

      def install
        bin.install "ud_0.28.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.1", shell_output("#{bin}/ud --version")
  end
end
