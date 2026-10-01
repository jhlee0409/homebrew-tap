cask "claude-code-history-viewer" do
  version "1.30.0"
  sha256 "d42908b1694a84edd285235b9b800b6b8d962759b1bb31f03453db4b631f2443"

  url "https://github.com/jhlee0409/claude-code-history-viewer/releases/download/v#{version}/Claude.Code.History.Viewer_#{version}_universal.dmg"

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