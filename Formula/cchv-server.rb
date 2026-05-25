class CchvServer < Formula
  desc "Claude Code History Viewer - WebUI Server (headless HTTP server)"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"
  license "MIT"
  version "1.13.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "c2374be328ebc99ee7c1b85f23618f276b6c05ea5c411f85bd93b037fd6c9233"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "d7db0e2df230cd88353ceb3a101d95bc8ec8e8a7314499f8e9d63a6ae0648e0a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "a3b8482b947da0b83d23557f06a2476013e97de6dc488405337aeb3554727771"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "83f27a12b78876ce507718070c0ef26121b17e892bc81f4a8a07667fb0921fb1"
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
