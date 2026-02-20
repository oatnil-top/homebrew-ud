class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.33.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_darwin_arm64.tar.gz"
      sha256 "282d7729fbd0f4d0cdbdb45df9c88ef10b07671e0a9f3206617d37ead609e0b5"

      def install
        bin.install "ud_0.33.1_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_darwin_amd64.tar.gz"
      sha256 "c6f3b0401094987597eecee6127c1d5ee4c91c8cb7ff9617b3d7a7ef460d1559"

      def install
        bin.install "ud_0.33.1_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_linux_arm64.tar.gz"
      sha256 "66aae459a3332a069b97b7fd77b583d96303e3fdac04d87167671cf1780a644d"

      def install
        bin.install "ud_0.33.1_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.1/ud_0.33.1_linux_amd64.tar.gz"
      sha256 "3668810ac5f71749e92ce32370ff942050b6021adf20a2ff0fced86ca1d43807"

      def install
        bin.install "ud_0.33.1_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.33.1", shell_output("#{bin}/ud --version")
  end
end
