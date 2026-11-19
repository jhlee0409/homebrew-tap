require "json"

class CchvServer < Formula
  desc "Omnilogue WebUI server"
  homepage "https://github.com/jhlee0409/omnilogue"
  license "MIT"
  version "2.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "a0e50857246a5d6b35a359b7f32f616b7f98dee43a123b5e810aa6b9288652e7"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "4401d28b2f8ef029b6c0688d0de4bae1bb37a5280c1bc84dcb3316f575b6b89f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "2abc92541a934c35005282bcd3a73792687cbcf2fefbadad7095a17a7e6f3401"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "de277e90f969b87bae86046197e3184d2b9114f6abff534012431e22af905946"
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
