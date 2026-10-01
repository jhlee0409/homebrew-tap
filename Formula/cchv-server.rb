class CchvServer < Formula
  desc "Claude Code History Viewer - WebUI Server (headless HTTP server)"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"
  license "MIT"
  version "1.30.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "c88228c662d4e03ba07cabe0f8acac04fce29a0329eb4a8bece52c14f50cac53"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "cb6eedd7b579b09a8708e895f67341613ffe70738766183d61da7e93e55c3388"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "3f486ce17a9dfc6c9dff08dbd089b4e0a2dbba6dab2a74e4249aff98239549ad"
    else
      url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "e4ca59de4843fa1ae1f4bcdbd23b23b1aa9b2922945c2a14034243f45f50da8f"
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
