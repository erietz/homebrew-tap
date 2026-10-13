class Nlock < Formula
  desc "Run commands while holding named locks"
  homepage "https://github.com/erietz/nlock"
  version "0.1.3"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.3/nlock-macos-aarch64.tar.gz"
      sha256 "1d04d2ecd2db8fa3133ce1a5b9d6a1d6adb8dbdbed6bd73b8acfe8063c471d8d"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.3/nlock-macos-x86_64.tar.gz"
      sha256 "7d140915546afb7a4c09583e28be14210305358bb39fdab7f89d7ad246b54482"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/erietz/nlock/releases/download/v0.1.3/nlock-linux-aarch64.tar.gz"
      sha256 "ff41b1b561a49404ffc2898ca36c7a3860bb0b702cda56eb63f32b208ea8e71d"
    elsif Hardware::CPU.intel?
      url "https://github.com/erietz/nlock/releases/download/v0.1.3/nlock-linux-x86_64.tar.gz"
      sha256 "4e3ff8b8aaf3a96455cefe212172bdffd7e19cd21abfa4b391d9d5eb52f8fe4a"
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
