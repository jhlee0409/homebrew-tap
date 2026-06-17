class ProcJanitor < Formula
  desc "Automatic orphan process cleanup daemon for macOS"
  homepage "https://github.com/jhlee0409/proc-janitor"
  license "MIT"
  version "0.8.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "0b13fd029a8d4cef3fc9c13bbbabad50a69fec86be2622982ddf305af36473cf"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "d6b7aa3d9b1240b854041aae2a7e47bfa60c16742bacd1f572195c83a9db3d58"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eed4d419878a06d634ee6b65e85966098484b21e4ed949ccf6d73ef47986cb55"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e0b30548002ce21686c35aed6909181f88de8b447c750db96f69aa3503e75349"
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
