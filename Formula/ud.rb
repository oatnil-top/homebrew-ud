class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.32.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.32.0/ud_0.32.0_darwin_arm64.tar.gz"
      sha256 "f81ce831476ba830b92758fa0af6656f26959464c11ec7fbb7276ab4e5af4884"

      def install
        bin.install "ud_0.32.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.32.0/ud_0.32.0_darwin_amd64.tar.gz"
      sha256 "4d03944b0a4ba14149fe8c178f898d1091e51210571e6f3fef1f438cc2b2e805"

      def install
        bin.install "ud_0.32.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.32.0/ud_0.32.0_linux_arm64.tar.gz"
      sha256 "770a5d71005ad6276caaa3d4822c18a12bb1ed741e9f7964823c58ffb3a5749f"

      def install
        bin.install "ud_0.32.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.32.0/ud_0.32.0_linux_amd64.tar.gz"
      sha256 "175099a5985635c597413faaee087da6f6eeff8948746a280ab2a502e0e7f1cc"

      def install
        bin.install "ud_0.32.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.32.0", shell_output("#{bin}/ud --version")
  end
end
