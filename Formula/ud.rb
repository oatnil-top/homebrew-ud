class Ud < Formula
  desc "UnderControl CLI - task and expense management from the terminal"
  homepage "https://github.com/oatnil-top/ud-cli"
  version "0.28.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.2/ud_0.28.2_darwin_arm64.tar.gz"
      sha256 "560cb4fafa400600d99c01e8dda9a944b76739adc5c60866815c3887b1d17e87"

      def install
        bin.install "ud_0.28.2_darwin_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.2/ud_0.28.2_darwin_amd64.tar.gz"
      sha256 "360447c27398d7dab570ff69813756a9614716e7a397613566f6a67076919f94"

      def install
        bin.install "ud_0.28.2_darwin_amd64" => "ud"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.2/ud_0.28.2_linux_arm64.tar.gz"
      sha256 "7236b48bad26a4fc1e52bfc64a195673eca617108c842194a6f83028575097a2"

      def install
        bin.install "ud_0.28.2_linux_arm64" => "ud"
      end
    else
      url "https://pub-35d77f83ee8a41798bb4b2e1831ac70a.r2.dev/cli/releases/0.28.2/ud_0.28.2_linux_amd64.tar.gz"
      sha256 "b257b1df654ae0d63230bed63f208c25a50cb447d826f07b639008ec218abc41"

      def install
        bin.install "ud_0.28.2_linux_amd64" => "ud"
      end
    end
  end

  test do
    assert_match "ud version 0.28.2", shell_output("#{bin}/ud --version")
  end
end
