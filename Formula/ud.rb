class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.21.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.10/ud_0.21.10_darwin_arm64.tar.gz"
      sha256 "40d384cdf0b9a4a24f13fea4dc26299d3439d1f27780ec343d0e827df2393c77"

      def install
        bin.install "ud_0.21.10_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.10/ud_0.21.10_darwin_amd64.tar.gz"
      sha256 "a9cae4f28e0a7ff382d60acd1fb35c315f8246a532e1fe468f11c92588aaf749"

      def install
        bin.install "ud_0.21.10_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.10/ud_0.21.10_linux_arm64.tar.gz"
      sha256 "47763c1d6799baefed6b8782b11793df330089021edc4334ea0e3182a4c9fc82"

      def install
        bin.install "ud_0.21.10_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.21.10/ud_0.21.10_linux_amd64.tar.gz"
      sha256 "14448672429db7fbf7bd0ff4eea8de1fa0ff201abdd774fd049e0b27612107d2"

      def install
        bin.install "ud_0.21.10_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.21.10", shell_output("#{bin}/ud --version")
  end
end
