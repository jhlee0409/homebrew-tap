class ProcJanitor < Formula
  desc "Automatic orphan process cleanup daemon for macOS"
  homepage "https://github.com/jhlee0409/proc-janitor"
  license "MIT"
  version "0.10.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "f2fde48e9dec7bb0004aacb0a3dd324b64505093d45c72e61c8482cde41d1c73"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "025051d5b4686357d02d527997dc2df83c97ba666509c7823fa85186141cbf88"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ed42ce233f6bce89981f89f81e5b986cb81e49c5d735fb0593f2b57d3d6977d"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bb6111bcc5fb8dcd7bd41bf647abfe169143705aa6a530e40255f4a61f0cb67c"
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
