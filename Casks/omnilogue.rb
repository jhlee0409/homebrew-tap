cask "omnilogue" do
  version "2.2.0"
  sha256 "e89ee2a8ce53c186ea732af62e9eae424f2d109e4188097697aa2e5dec18ccd9"

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