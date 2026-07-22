class CchvServer < Formula
  desc "Claude Code History Viewer - WebUI Server (headless HTTP server)"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"
  license "MIT"
  version "1.22.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "d57c33e1496d3db9addc1b55a497723cd593b3ada5d0040b12ec94df3a299340"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "c58783413fa29229a6febaf3fbb8207625c0ad08d986076de6896e1dac8e2851"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "a0696f32f762c067df2548ab02f8ac536dae1082ac2f8f2da2bdfbee3ed6d7bd"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "08510db4ef0b40193516affe97542db0aee605a4d8ccad8218aa6e026f78f9fc"
    end
  end

  def install
    bin.install "cchv-server"
  end

  service do
    run [opt_bin/"cchv-server", "--serve"]
    keep_alive true
    log_path var/"log/cchv-server.log"
    error_log_path var/"log/cchv-server-error.log"
  end

  test do
    assert_match "WebUI server", shell_output("#{bin}/cchv-server --help 2>&1", 1)
  end
end
