# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.2/ud_0.21.2_darwin_arm64.tar.gz"
      sha256 "f11aa5fc1293aa5334968131a90c8e4f38bf2a86e0061f4dee8a60c5211c04a3"

      def install
        bin.install "ud_0.21.2_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.2/ud_0.21.2_darwin_amd64.tar.gz"
      sha256 "7657126561dfd6cbd661e27566c2fa09c8e28eb516c27ad69e5c523d678a3d50"

      def install
        bin.install "ud_0.21.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.2/ud_0.21.2_linux_arm64.tar.gz"
      sha256 "60938c668d8396fe66383e42fd37d080be42195031b886e6fa48826e59ef2270"

      def install
        bin.install "ud_0.21.2_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.2/ud_0.21.2_linux_amd64.tar.gz"
      sha256 "a780f8c4afc93558a6ea95216b674264ba959a9b5d3c2bc6e110e1fedecac82f"

      def install
        bin.install "ud_0.21.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
