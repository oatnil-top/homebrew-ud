# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.3/ud_0.21.3_darwin_arm64.tar.gz"
      sha256 "2efd3a3e4f022077e52fc928222ff149c6650fbf6ffcab4e72f1d7406cef9f27"

      def install
        bin.install "ud_0.21.3_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.3/ud_0.21.3_darwin_amd64.tar.gz"
      sha256 "b9a0cbd8f40c56b4609ed4f3ee0964a74287ad84abbf35f304be7b64bb180388"

      def install
        bin.install "ud_0.21.3_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.3/ud_0.21.3_linux_arm64.tar.gz"
      sha256 "5ffec5962e6539fd1fcdfab0e922a26ea90e9b2aa13e7f34dd372cb8e2a644e6"

      def install
        bin.install "ud_0.21.3_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.3/ud_0.21.3_linux_amd64.tar.gz"
      sha256 "be898dd97f18b001ca2042a355a7773e728af3679df2a1ec334dc80c0145dd32"

      def install
        bin.install "ud_0.21.3_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
