class ProcJanitor < Formula
  desc "Automatic orphan process cleanup daemon for macOS"
  homepage "https://github.com/jhlee0409/proc-janitor"
  license "MIT"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-apple-darwin.tar.gz"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-apple-darwin.tar.gz"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
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
