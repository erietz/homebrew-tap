class Zigstronaut < Formula
  desc "Space-themed terminal animation in ASCII art"
  homepage "https://github.com/erietz/zigstronaut"
  version "release-03b131c"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/zigstronaut/releases/download/release-03b131c/zigstronaut-macos-aarch64.tar.gz"
      sha256 "28d7e858034111ce9adbcae23cfa177b3f807a64b280d4c674fb966c324c40f9"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/zigstronaut/releases/download/release-03b131c/zigstronaut-macos-x86_64.tar.gz"
      sha256 "573b35be23cb11147a74c5f836c0748ef712c24f48aa959cb501495816ac22f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/zigstronaut/releases/download/release-03b131c/zigstronaut-linux-aarch64.tar.gz"
      sha256 "d4303090282d58cfe71287da664067059e3cef84a178f877f6cba0bcc750f77a"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/zigstronaut/releases/download/release-03b131c/zigstronaut-linux-x86_64.tar.gz"
      sha256 "161ba6e65defa1c17b85e9f0c34031372f311f72162f28ce26fcbc682a99bbac"
    end
  end

  def install
    bin.install "zigstronaut"
  end

  test do
    assert_predicate bin/"zigstronaut", :executable?
  end
end
