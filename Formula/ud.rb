# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.49.0"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.49.0/ud_0.49.0_darwin_arm64.tar.gz"
      sha256 "164197e6b4ebb7f10f623c53dd4e641114da000db7381ac6e721e30e3c4bcf9e"

      def install
        bin.install "ud_0.49.0_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.49.0/ud_0.49.0_darwin_amd64.tar.gz"
      sha256 "a5117edbca5c0de2584a3c19c17e2d8947839005b8bf49b4699dddfc8240c74f"

      def install
        bin.install "ud_0.49.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.49.0/ud_0.49.0_linux_arm64.tar.gz"
      sha256 "b5cf4988b9e52fc1190b3ea6b29e651eb7b66b622d1a4f07cb6b294ae014556c"

      def install
        bin.install "ud_0.49.0_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.49.0/ud_0.49.0_linux_amd64.tar.gz"
      sha256 "503a9c79d508ec9678905e48cd37605f9e0f0487ce5f3f637740f820dbd5721d"

      def install
        bin.install "ud_0.49.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
