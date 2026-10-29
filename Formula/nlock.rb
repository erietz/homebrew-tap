class Nlock < Formula
  desc "Run commands while holding named locks"
  homepage "https://github.com/erietz/nlock"
  version "0.1.8"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.8/nlock-macos-aarch64.tar.gz"
      sha256 "ee3c0d0fee2fb981991ab56518888aaa168dc1fd44809ff587ad6f5b92a33633"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.8/nlock-macos-x86_64.tar.gz"
      sha256 "b7081b14a1180218083c30227891f4f7b2528c1b4894aa8c70d6a5d70fd72da7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.8/nlock-linux-aarch64.tar.gz"
      sha256 "5681dbaed08eae503b63b7fcc40f3f515fefa92e52b85ad5c1481bcb8972b805"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.8/nlock-linux-x86_64.tar.gz"
      sha256 "087f6a3fba291d1eac384fec21264a38452c185bb31291bace475db158a98c00"
    end
  end

  def install
    bin.install "nlock"
    bin.install "nlockd"
    man1.install "share/man/man1/nlock.1" if File.exist?("share/man/man1/nlock.1")
    man1.install "share/man/man1/nlockd.1" if File.exist?("share/man/man1/nlockd.1")
    if OS.mac?
      (share/"nlock/launchd").install "share/nlock/launchd/com.erietz.nlockd.plist" if File.exist?("share/nlock/launchd/com.erietz.nlockd.plist")
    elsif OS.linux?
      (share/"systemd/user").install "share/systemd/user/nlockd.service" if File.exist?("share/systemd/user/nlockd.service")
    end
  end

  service do
    run [opt_bin/"nlockd"]
    keep_alive true
    log_path var/"log/nlockd.log"
    error_log_path var/"log/nlockd.log"
    environment_variables NLOCK_LOG_LEVEL: "Debug"
  end

  test do
    output = shell_output("#<built-in function bin>/nlock 2>&1", 1)
    assert_match "Usage: nlock", output
  end
end
