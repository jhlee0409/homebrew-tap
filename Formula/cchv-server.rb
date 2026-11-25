require "json"

class CchvServer < Formula
  desc "Omnilogue WebUI server"
  homepage "https://github.com/jhlee0409/omnilogue"
  license "MIT"
  version "2.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "ce21db31cb771bfeebdac5d34555ea8bae60131428d896e8e66e8c56ef98bd0c"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "b9a73987e7da7f1c0e1a457af293cc7146f2740ed1aaadd1bbcf9937ef68da22"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "32df9b032e181cb08b4f7172c9ea693a3df97913130f29f04831bd5cdb858956"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "3788f6c066012b36ec5974e1c0b7981bfc10b02593c8bb8c49ce329f653231de"
    end
  end

  def install
    bin.install "cchv-server"
  end

  service do
    run [opt_bin/"cchv-server", "--serve", "--host", "127.0.0.1"]
    keep_alive true
    log_path var/"log/cchv-server.log"
    error_log_path var/"log/cchv-server-error.log"
  end

  test do
    port = free_port
    pid = fork { exec bin/"cchv-server", "--serve", "--host", "127.0.0.1", "--port", port.to_s, "--read-only" }
    begin
      response = shell_output("curl --fail --silent --retry-connrefused --retry 10 http://127.0.0.1:#{port}/health")
      assert_equal "ok", JSON.parse(response)["status"]
    ensure
      Process.kill("TERM", pid)
      Process.wait(pid)
    end
  end
end
