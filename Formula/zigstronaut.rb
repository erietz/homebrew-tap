class Zigstronaut < Formula
  desc "Space-themed terminal animation in ASCII art"
  homepage "https://github.com/erietz/zigstronaut"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/zigstronaut/releases/latest/download/zigstronaut-macos-aarch64.tar.gz"
      sha256 "PLACEHOLDER"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/zigstronaut/releases/latest/download/zigstronaut-macos-x86_64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/zigstronaut/releases/latest/download/zigstronaut-linux-aarch64.tar.gz"
      sha256 "PLACEHOLDER"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/zigstronaut/releases/latest/download/zigstronaut-linux-x86_64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "zigstronaut"
  end

  test do
    assert_predicate bin/"zigstronaut", :executable?
  end
end
