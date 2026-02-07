class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.25.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.0/ud_0.25.0_darwin_arm64.tar.gz"
      sha256 "b55c6bc7bf8b5a289c579ec6e8427e8540cfbc147492187dcb6e498406c8719d"

      def install
        bin.install "ud_0.25.0_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.0/ud_0.25.0_darwin_amd64.tar.gz"
      sha256 "df28d21835cbc757062faf5d6060ee01751999cb2b344bfe595d58fe6f3f5b09"

      def install
        bin.install "ud_0.25.0_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.0/ud_0.25.0_linux_arm64.tar.gz"
      sha256 "9e17a5559e5bbb86d7406b92ae7592365fe3d679ee0f49a076b73f5ab442753d"

      def install
        bin.install "ud_0.25.0_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.25.0/ud_0.25.0_linux_amd64.tar.gz"
      sha256 "f2e04c7dc483c26c62eeec04d879be7a5accc32adebd7d665124c436af037ccd"

      def install
        bin.install "ud_0.25.0_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.25.0", shell_output("#{bin}/ud --version")
  end
end
