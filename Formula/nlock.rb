class Nlock < Formula
  desc "Run commands while holding named locks"
  homepage "https://github.com/erietz/nlock"
  version "0.1.6"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.6/nlock-macos-aarch64.tar.gz"
      sha256 "0977ed345645d320c9eeeb065e0252c96db830b12f5cf957a11425aef0d2b444"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.6/nlock-macos-x86_64.tar.gz"
      sha256 "0fd071ca7468c0c74a3836a96e90ac677edcd79cdd4a044434b3f8c6756f461e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.6/nlock-linux-aarch64.tar.gz"
      sha256 "d9a49941a5de474785975c0079f01c12ddd868bcb60c31674a4a0f62b4ac2746"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.6/nlock-linux-x86_64.tar.gz"
      sha256 "774a5e85b220ae1182e83cbb660effd66a9e0bf42243089d3dc5aef24f88215a"
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
