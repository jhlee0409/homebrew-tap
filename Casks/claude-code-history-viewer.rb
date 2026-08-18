cask "claude-code-history-viewer" do
  version "1.25.0"
  sha256 "576af26a543c21b45c020a735b7de056a096b74491ba8ca28c607d8289416a9e"

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