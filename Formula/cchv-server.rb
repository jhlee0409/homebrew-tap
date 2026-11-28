require "json"

class CchvServer < Formula
  desc "Omnilogue WebUI server"
  homepage "https://github.com/jhlee0409/omnilogue"
  license "MIT"
  version "2.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-arm64.tar.gz"
      sha256 "970b1138cd5b59a68921e6c6c604af2a511694ff9e1f77e560614615d184a3bb"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-macos-x64.tar.gz"
      sha256 "7b8b35fe1f86fecad4b64c2c98a0490e0fd28e1836cb5ea4b6ce982f0ce7d72b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-arm64.tar.gz"
      sha256 "4dfc58ef1967cecb9bffdb239ebe491429fbcf4d960b4dbf3caa0276f6ad878a"
    else
      url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/cchv-server-linux-x64.tar.gz"
      sha256 "b00f42a1a587be975af960edba3fb2f3ab4bdbc7e80d5667934d5504c3c3261a"
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
