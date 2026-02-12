class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.4/ud_0.28.4_darwin_arm64.tar.gz"
      sha256 "43c27aa7b67443c854491857578200a4af6365de12238a78cb16a9e3feb84f17"

      def install
        bin.install "ud_0.28.4_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.4/ud_0.28.4_darwin_amd64.tar.gz"
      sha256 "5209d483a296433486b14046612a365ba942f14764251085c7360a42284b6c12"

      def install
        bin.install "ud_0.28.4_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.4/ud_0.28.4_linux_arm64.tar.gz"
      sha256 "0bb7269aab00c4b82475f131b3f3da20f6280fb0335d488e26cf9785a52dfe28"

      def install
        bin.install "ud_0.28.4_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.4/ud_0.28.4_linux_amd64.tar.gz"
      sha256 "35a5e17d15d234d7ae6b09dc61885b85de796c5fdb62a512b191183c035cafa9"

      def install
        bin.install "ud_0.28.4_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.4", shell_output("#{bin}/ud --version")
  end
end
