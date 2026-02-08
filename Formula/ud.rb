class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.1/ud_0.25.1_darwin_arm64.tar.gz"
      sha256 "c188d4602ccd3c7052cd4c99b852fd0047eb81658ae7b913e207caeef8da1bfc"

      def install
        bin.install "ud_0.25.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.1/ud_0.25.1_darwin_amd64.tar.gz"
      sha256 "5c24706ef9d08ffbac8a9b0fffa1778749cc2efdf626a7e05f3ea81382615ce0"

      def install
        bin.install "ud_0.25.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.1/ud_0.25.1_linux_arm64.tar.gz"
      sha256 "44f037fd97ae554df4c4943d6b5bbf037d4fb118e41dfe55604813515bf7c0de"

      def install
        bin.install "ud_0.25.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.1/ud_0.25.1_linux_amd64.tar.gz"
      sha256 "a22f326634a2fd1a751d4c70212f05cc08293d5c69d89b3db4107558d7c8696f"

      def install
        bin.install "ud_0.25.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.1", shell_output("#{bin}/ud --version")
  end
end
