class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.0/ud_0.35.0_darwin_arm64.tar.gz"
      sha256 "c0182c9d0459bf0bf5398778b482904f496b3232e9e9dc92bf0e05796391c56a"

      def install
        bin.install "ud_0.35.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.0/ud_0.35.0_darwin_amd64.tar.gz"
      sha256 "3b2844bfe2bf84530ae0d66b65a01227871b3cb3cfc3cae3b68d564c32bc003b"

      def install
        bin.install "ud_0.35.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.0/ud_0.35.0_linux_arm64.tar.gz"
      sha256 "60673816bdd4cc36a6f8ec77665d28499947d6470a0b508f099e3704e229e8d8"

      def install
        bin.install "ud_0.35.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.0/ud_0.35.0_linux_amd64.tar.gz"
      sha256 "356c25d80da38a6ab4abe889d65ecb648e92506c1eb6890b6e836d16aae98c23"

      def install
        bin.install "ud_0.35.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.0", shell_output("#{bin}/ud --version")
  end
end
