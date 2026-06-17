class ProcJanitor < Formula
  desc "Automatic orphan process cleanup daemon for macOS"
  homepage "https://github.com/jhlee0409/proc-janitor"
  license "MIT"
  version "0.8.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-apple-darwin.tar.gz"
      sha256 "bac4297e754f5f0ac725f6c368bb0bb53cc65a8252c120f344dbc44690128d06"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-apple-darwin.tar.gz"
      sha256 "828239b82f7da85e0d486934110fdcfad4c30273a463932e329e28a964ea0a8e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0126de6844444f86156983e1d7864b7037917fb8363a7cf2cfb50da465cd9f86"
    else
      url "https://github.com/jhlee0409/proc-janitor/releases/download/v#{version}/proc-janitor-v#{version}-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8151b1935c3e2bf658f9b6e8e69243902e1631b69856969e9f9a0abe5139e72"
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
