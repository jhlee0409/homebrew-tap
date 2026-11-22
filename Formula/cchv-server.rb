require "json"

class CchvServer < Formula
  desc "Omnilogue WebUI server"
  homepage "https://github.com/jhlee0409/omnilogue"
  license "MIT"
  version "2.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "e04962a2d0604d2500516e92e6e626bd7b027c1c7779f1ad13408060cfa2805a"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "2572abf5a183f80626c52273cae8d125c702c75f500d9bee399469dbcf92a7b8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "d94b01404eb864ce6828f8a4033f6c0251f000611b1389cb1fd55ede5a480b4c"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "602a64e5a9fc7a3b07db7190960f2da30f3fe2c8b9e8948349ab7da0126a0d3c"
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
