cask "claude-code-history-viewer" do
  version "1.3.0"
  sha256 "037abb302520d699769d22ae6051331d56bc8b7357f945ae74c5bfcfd2c46013"

  url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/Claude.Code.History.Viewer_#{version}_universal.dmg",
      verified: "github.com/jhlee0409/claude-code-history-viewer/"

  name "Claude Code History Viewer"
  desc "Browse and analyze Claude Code conversation history offline"
  homepage "https://github.com/jhlee0409/claude-code-history-viewer"

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
