# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://oatnil-public.s3.bitiful.net/cli/releases/0.21.1/ud_0.21.1_darwin_arm64.tar.gz"
      sha256 "dcfce3aaf43cc8a750b7e19e7d5356c39142acf38783d8abb583557d69b704e0"

      def install
        bin.install "ud_0.21.1_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://oatnil-public.s3.bitiful.net/cli/releases/0.21.1/ud_0.21.1_darwin_amd64.tar.gz"
      sha256 "29ddd1993b2d0c00171729cddf991b05acec6d449723cdc59252a466439db9c6"

      def install
        bin.install "ud_0.21.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://oatnil-public.s3.bitiful.net/cli/releases/0.21.1/ud_0.21.1_linux_arm64.tar.gz"
      sha256 "04bbf84f4ffb1c2a0bb42ac14352bad9bf9e182bb3d2fc1d92ac889f7edd67ff"

      def install
        bin.install "ud_0.21.1_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://oatnil-public.s3.bitiful.net/cli/releases/0.21.1/ud_0.21.1_linux_amd64.tar.gz"
      sha256 "dceb5b3bcf1f92ed7b7e4e924f920d3e0cfbd9dc5e6cfcbfcd38ffbc3dd6f336"

      def install
        bin.install "ud_0.21.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
