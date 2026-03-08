cask "claude-code-history-viewer" do
  version "1.6.0"
  sha256 "41470eb3c1584db093fcb23cd344a31f580f8a02d74d66047434e7f70dabdcdd"

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