class ProcJanitor < Formula
  desc "Automatic orphan process cleanup daemon for macOS"
  homepage "https://github.com/jhlee0409/proc-janitor"
  license "MIT"
  version "0.8.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "b1719c1a00667d6a32b5f22b8094f73898ccd23fe1157490912e5e9c1d2aca73"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "0ec6a753df9ab88284d4a3deacd61bb5ed31fc1f01c25a5f788484a3fde4541f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "515bfbd6dafb10504c132ebd3ac15e6e38c6ad63e335f40f99320e7f69e2568b"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2928d03354f30d8877b68469a84e4e9641aed9a3bd91cdd43d0c41d915e508bd"
    end
  end

  def install
    bin.install "proc-janitor"
  end

  service do
    run [opt_bin/"proc-janitor", "start", "--foreground"]
    keep_alive true
    log_path var/"log/proc-janitor.log"
    error_log_path var/"log/proc-janitor-error.log"
  end

  test do
    assert_match "proc-janitor", shell_output("#{bin}/proc-janitor version")
  end
end
