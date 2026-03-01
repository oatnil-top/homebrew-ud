class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.35.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.6/ud_0.35.6_darwin_arm64.tar.gz"
      sha256 "c622494fafdc4e6a2a635eb498284cc95cebb0dbbda61438af7a17de3ebaf556"

      def install
        bin.install "ud_0.35.6_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.6/ud_0.35.6_darwin_amd64.tar.gz"
      sha256 "0a7bb0c34b2733a7bcc8ffe86d104944f50f45df7e45eb2408f6a90a7711daab"

      def install
        bin.install "ud_0.35.6_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.6/ud_0.35.6_linux_arm64.tar.gz"
      sha256 "dd616d4fedec8bc8497ba53d7e4ab30aea0e68b92e5cc4e767210fd7bee9f629"

      def install
        bin.install "ud_0.35.6_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.35.6/ud_0.35.6_linux_amd64.tar.gz"
      sha256 "77f70d4f5522a4458ab5bcff7f7e117d4b3439b91c022f51172487153364c903"

      def install
        bin.install "ud_0.35.6_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.35.6", shell_output("#{bin}/ud --version")
  end
end
