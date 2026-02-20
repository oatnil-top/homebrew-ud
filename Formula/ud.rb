class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.33.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.2/ud_0.33.2_darwin_arm64.tar.gz"
      sha256 "fe92dfc079738c19375018301a79d1ee94f49b731306c0cd038cce3dbb861e49"

      def install
        bin.install "ud_0.33.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.2/ud_0.33.2_darwin_amd64.tar.gz"
      sha256 "9fe29d2a9eaf25915997fc8850dfe27b9f63e01ff2d4bbe6c38f12418d75b6b8"

      def install
        bin.install "ud_0.33.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.2/ud_0.33.2_linux_arm64.tar.gz"
      sha256 "abc81c4266468e759a43f2e667933b8d065ccbb6ba74862de3d226b67968fc9b"

      def install
        bin.install "ud_0.33.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.33.2/ud_0.33.2_linux_amd64.tar.gz"
      sha256 "17721bb0530dfc6bbb0a6960363e9e308bee490702163ac58d99e8e5a6d6c9bf"

      def install
        bin.install "ud_0.33.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.33.2", shell_output("#{bin}/ud --version")
  end
end
