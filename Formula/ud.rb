class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.27.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.2/ud_0.27.2_darwin_arm64.tar.gz"
      sha256 "f526f69d5bd0bd3fee30477d2cc0df56d4172bcd4b63eff8b362a04d2fb995b8"

      def install
        bin.install "ud_0.27.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.2/ud_0.27.2_darwin_amd64.tar.gz"
      sha256 "fb8a71a8bb12da1a73cec87bf308ec4463f235d124b0311e54ee4db97359ec4a"

      def install
        bin.install "ud_0.27.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.2/ud_0.27.2_linux_arm64.tar.gz"
      sha256 "b51aa5d3ab27a434aa4d22dd7f8b07166e90a6e91438fa4ce6a540961194e23d"

      def install
        bin.install "ud_0.27.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.27.2/ud_0.27.2_linux_amd64.tar.gz"
      sha256 "0935b6c930eb1463ee375a9c5e63c05fc4ec7451ce19f706639456a5777474c7"

      def install
        bin.install "ud_0.27.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.27.2", shell_output("#{bin}/ud --version")
  end
end
