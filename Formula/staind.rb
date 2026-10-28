class Staind < Formula
  desc "Color command output written to a FIFO"
  homepage "https://github.com/erietz/staind"
  version "1.0.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/staind/releases/download/v1.0.0/staind-macos-aarch64.tar.gz"
      sha256 "a8ff9cfaa34795ec00132fce73e1b800bf856a5a09e203b94e82f7ff5768818a"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/staind/releases/download/v1.0.0/staind-macos-x86_64.tar.gz"
      sha256 "388b7044ec54f1722cb58fd192d9886cd220402e26da9d2c39563c5eccb5f5d6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/staind/releases/download/v1.0.0/staind-linux-aarch64.tar.gz"
      sha256 "addd23d227d993911f79ddc640bff9e2733e48dc5d85355e62bd1aea8dce6404"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/staind/releases/download/v1.0.0/staind-linux-x86_64.tar.gz"
      sha256 "2cc92552dd5770904aef0f4618dc55456860466bbdc1c54b43582cee78ebf02a"
    end
  end

  def install
    bin.install "staind"
  end

  test do
    output = shell_output("#{bin}/staind -h 2>&1")
    assert_match "usage: cmd 2>$(staind", output
  end
end
