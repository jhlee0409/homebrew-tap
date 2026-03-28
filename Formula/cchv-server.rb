class CchvServer < Formula
  desc "Claude Code History Viewer - WebUI Server (headless HTTP server)"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"
  license "MIT"
  version "1.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "28c9ac60bab980d62bcf2b0152167238f2976c803c474998ceb449335c95dc7e"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "761d50e52473343bb5a7c5747491518d8ff956bb0bf3440d18569c8bf102739d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "2c3a446456009ee569cde78429eb699bb410df806ede3fb835a89ae340350985"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "792bb5e60ed89f7b4659764f6ea149f25c6c03b3c84be71636a7e0a2ceabd579"
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
