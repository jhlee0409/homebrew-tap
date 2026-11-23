require "json"

class CchvServer < Formula
  desc "Omnilogue WebUI server"
  homepage "https://github.com/jhlee0409/omnilogue"
  license "MIT"
  version "2.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "88a083fdb4b8e3255866b8c4b029a09536dd471075cc10fdddf56837642943b0"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "809488010fda96c9ba24d5cf424e8bef0db62a3b20ee7c7d1220a077e6002619"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "64c9507134ada0f8e8b81795ea3e60e64321af862214f758a42da06c8a59a0ec"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "04a0930440abe3bfd584d6a37f49f8c49860aed17d733d48a01cbbed838b21b2"
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
