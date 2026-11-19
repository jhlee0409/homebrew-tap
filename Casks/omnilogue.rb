cask "omnilogue" do
  version "2.0.0"
  sha256 "b22164b1fdeda5b1520f3db1972bcd27bd5e88d9bf90f2ac69abcb5560568630"

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