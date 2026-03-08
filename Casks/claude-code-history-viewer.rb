cask "claude-code-history-viewer" do
  version "1.6.0"
  sha256 "5adbf0ce0da0b2fc66972e0ccdd6f0586044e92ad3dde8967ad80c8eef833a4d"

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