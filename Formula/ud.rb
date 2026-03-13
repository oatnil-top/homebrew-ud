# typed: false
# frozen_string_literal: true

class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.46.6"
  license "MIT"

  on_macos do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.46.6/ud_0.46.6_darwin_arm64.tar.gz"
      sha256 "64ed70e0b1a6fc8a2c875db8700e3f62143d2b1cfc5b81029bacc9169b59d9ba"

      def install
        bin.install "ud_0.46.6_darwin_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.46.6/ud_0.46.6_darwin_amd64.tar.gz"
      sha256 "5feef3a83ba21d563eab78648b2e0da5a06e7ab20ff1eb2e450e5618f4031d3d"

      def install
        bin.install "ud_0.46.6_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    on_arm do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.46.6/ud_0.46.6_linux_arm64.tar.gz"
      sha256 "2911c7516e9dca694cf7e7c1d85c801d760ee4023690291473154c5183a29f81"

      def install
        bin.install "ud_0.46.6_linux_arm64" => "ud"
      end
    end
    on_intel do
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.46.6/ud_0.46.6_linux_amd64.tar.gz"
      sha256 "b39ecbf8a7f5f8efbb90e2b5a566c50e301653b9f50e21626b8054769bff946d"

      def install
        bin.install "ud_0.46.6_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ud --version")
  end
end
