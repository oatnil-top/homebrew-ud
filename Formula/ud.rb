class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.34.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.4/ud_0.34.4_darwin_arm64.tar.gz"
      sha256 "fe23b6b0d8038a17ab231321af88a35a96df2a388564147a700cb66501fd1090"

      def install
        bin.install "ud_0.34.4_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.4/ud_0.34.4_darwin_amd64.tar.gz"
      sha256 "cbc39f1c09f2ff17bc49254248fa83e1156a4ecf9bbfc50733c73cea95ebc869"

      def install
        bin.install "ud_0.34.4_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.4/ud_0.34.4_linux_arm64.tar.gz"
      sha256 "98b12621c2ee3b80c211fd552301d32806b4bccba32aedbe4300aff3a17f7f4b"

      def install
        bin.install "ud_0.34.4_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.34.4/ud_0.34.4_linux_amd64.tar.gz"
      sha256 "5d43090063a38d3020c7bdb898d03e3b43c641693e87646d420d7fd7eb922a32"

      def install
        bin.install "ud_0.34.4_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.34.4", shell_output("#{bin}/ud --version")
  end
end
