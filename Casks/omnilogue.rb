cask "omnilogue" do
  version "2.1.1"
  sha256 "24f6b5b4ac92a9f2ef659ab7688fe4cf39346869f0583ee4fae4ea74d9af85cb"

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