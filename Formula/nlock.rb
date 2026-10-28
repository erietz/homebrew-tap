class Nlock < Formula
  desc "Run commands while holding named locks"
  homepage "https://github.com/erietz/nlock"
  version "0.1.7"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.7/nlock-macos-aarch64.tar.gz"
      sha256 "15f3ec073e6ec8598bb8ed52f83bf8bd5f311c9a634cfdc8cfd9eda86738fede"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.7/nlock-macos-x86_64.tar.gz"
      sha256 "b7fa1cdce5dbf5ed78a1095ddb4ab011e64a5a21f4f3e5c96cb3ec62db1f00b5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.7/nlock-linux-aarch64.tar.gz"
      sha256 "e76c6e137f219b3f4c1d765a89f32efc23874937735ca07ac2b20346202b1f0b"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.7/nlock-linux-x86_64.tar.gz"
      sha256 "39b97d94994ddf5cbaef19d0cc352c1ae5d3b4bb8b9add6cbd701f19a8aaa081"
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
