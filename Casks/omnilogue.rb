cask "omnilogue" do
  version "2.1.0"
  sha256 "74ce6787d56ec1470d5e253985c9d1d1e550facf9bfeffe43aa5e52f5c58fbba"

  url "https://github.com/jhlee0409/omnilogue/releases/download/v#{version}/Claude.Code.History.Viewer_#{version}_universal.dmg"

  name "Omnilogue"
  desc "Browse and analyze AI coding assistant history offline"
  homepage "https://github.com/jhlee0409/omnilogue"

  auto_updates true

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Claude Code History Viewer.app"

  zap trash: [
    "~/Library/Application Support/com.claude.history-viewer",
    "~/Library/Caches/com.claude.history-viewer",
    "~/Library/Preferences/com.claude.history-viewer.plist",
    "~/Library/Saved Application State/com.claude.history-viewer.savedState",
  ]
end