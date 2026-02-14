class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.30.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.0/ud_0.30.0_darwin_arm64.tar.gz"
      sha256 "4c66c9c549da4ca27971221218e662a19053279f227df1d85d9a9da04a6d1667"

      def install
        bin.install "ud_0.30.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.0/ud_0.30.0_darwin_amd64.tar.gz"
      sha256 "7fd57af55ee952cee0848c70c1d25e1754f835f539573ad78cd181d016698ef9"

      def install
        bin.install "ud_0.30.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.0/ud_0.30.0_linux_arm64.tar.gz"
      sha256 "fbf5e9f74c4dbd99e7fb3a815d92cc98a234d89fe8a69df67215e403a48043d3"

      def install
        bin.install "ud_0.30.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.30.0/ud_0.30.0_linux_amd64.tar.gz"
      sha256 "2295d9227560a1d17f311850e30e164c12b78ec9c88e7d27e660783fc4d35698"

      def install
        bin.install "ud_0.30.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.30.0", shell_output("#{bin}/ud --version")
  end
end
