class Nlock < Formula
  desc "Run commands while holding named locks"
  homepage "https://github.com/erietz/nlock"
  version "0.1.0"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.0/nlock-macos-aarch64.tar.gz"
      sha256 "2d8b8653d920e5315ead761a096cdf22e4616041c9c4a214a625f67382e9222e"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.0/nlock-macos-x86_64.tar.gz"
      sha256 "73618e3c4135f95004c9533bfe053af24e442ad67811158dba5c41f8f40ae0e0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.0/nlock-linux-aarch64.tar.gz"
      sha256 "948f02ac686fda70abcff36a5cbfa3d0e4983864bb73df226f8aaf267b9d48d3"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.0/nlock-linux-x86_64.tar.gz"
      sha256 "9c4b5684ddbda59b5b620c30979c39a9c4395710cadb20b9558de104816770d2"
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
