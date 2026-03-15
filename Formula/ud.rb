# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.48.1"
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.48.1/ud_0.48.1_darwin_arm64.tar.gz"
      sha256 "377353aec2376607dbe8c09bd38b2eb45a3121a971898cbd49ddc382ed96c22b"

      def install
        bin.install "ud_0.48.1_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.48.1/ud_0.48.1_darwin_amd64.tar.gz"
      sha256 "c0cc6d6b36a8389e11fc39237e520d835164bd139b6d93795c03322c8aab3c33"

      def install
        bin.install "ud_0.48.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.48.1/ud_0.48.1_linux_arm64.tar.gz"
      sha256 "90d1f11cf28ded882554bd634f38e5b06b6f4087860408198fd3b8a2a662df41"

      def install
        bin.install "ud_0.48.1_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.48.1/ud_0.48.1_linux_amd64.tar.gz"
      sha256 "9ff780edd5eb4168c8c6763cd478731c268c2c6b747957a599041fbe73ed829a"

      def install
        bin.install "ud_0.48.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
