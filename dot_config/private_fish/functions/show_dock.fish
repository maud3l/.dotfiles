function show-dock
  # No arguments are passed.
  if set -q "$argv[1]"
    echo "Usage: show-dock true/false"
    return 1
  end
  if string match -q "false" "$argv[1]"
    # Hide Dock
    defaults write com.apple.dock autohide -bool true && killall Dock
    defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
    defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
  end
  
  if string match -q "true" "$argv[1]"
    # Restore Dock
    defaults write com.apple.dock autohide -bool false && killall Dock
    defaults delete com.apple.dock autohide-delay && killall Dock
    defaults write com.apple.dock no-bouncing -bool FALSE && killall Dock
  end
end
