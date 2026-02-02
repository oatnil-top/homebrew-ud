class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.22.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.0/ud_0.22.0_darwin_arm64.tar.gz"
      sha256 "bab6682056580aeed3b568dece2527f24de54503c3e4e202a6dae8a78a8c8b1b"

      def install
        bin.install "ud_0.22.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.0/ud_0.22.0_darwin_amd64.tar.gz"
      sha256 "bc131ced15bdf573d7a03ac254d6dfcb0f002e87d3e2ea898b1eb6453f344fdc"

      def install
        bin.install "ud_0.22.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.0/ud_0.22.0_linux_arm64.tar.gz"
      sha256 "689a2b13bcd8fe0874e403b27316d0dad14c152cbe1f536148c6b54348d3b754"

      def install
        bin.install "ud_0.22.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.22.0/ud_0.22.0_linux_amd64.tar.gz"
      sha256 "5c26e628634c9b531b81ee8e63775f01592c323b6c19bd148e74e86e142f54d4"

      def install
        bin.install "ud_0.22.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.22.0", shell_output("#{bin}/ud --version")
  end
end
