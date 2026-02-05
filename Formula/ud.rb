class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.23.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.23.0/ud_0.23.0_darwin_arm64.tar.gz"
      sha256 "4bc77c1ff59af05e015cccfa44c7e3836f9920b1de9f9e1ba6ea98ac2df5156f"

      def install
        bin.install "ud_0.23.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.23.0/ud_0.23.0_darwin_amd64.tar.gz"
      sha256 "743689f8d78e76fdcbbb22736f5954beff6567d5a7643619b4afdd1daf53af29"

      def install
        bin.install "ud_0.23.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.23.0/ud_0.23.0_linux_arm64.tar.gz"
      sha256 "2b1a799994d25bbe1462448e2d8ea809ebe2c4e92f1fa2b21a552dc271ed895f"

      def install
        bin.install "ud_0.23.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.23.0/ud_0.23.0_linux_amd64.tar.gz"
      sha256 "0edfbeb20d3e4408355df3d9deed5b1f54ff5941c7ba20b7addd13718ddae567"

      def install
        bin.install "ud_0.23.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.23.0", shell_output("#{bin}/ud --version")
  end
end
