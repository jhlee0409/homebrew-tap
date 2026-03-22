class CchvServer < Formula
  desc "Claude Code History Viewer - WebUI Server (headless HTTP server)"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"
  license "MIT"
  version "1.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "76f628ab24a1a3fceac3b86b6550a15a07aa508a32c7e8ae2659d477a6c0afed"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "bf7c0115c1c1dda928c63d9d1f21d598920de314d3cd00693e1e91f5e7ae6eab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "4d27f3be66b785973fe5e14858fdc067780c3824c7fa331db87051e916728129"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "613a1f2c1882b25400cdb47df4b8356f95ed91cc99e51b0962850e123e788b8c"
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
