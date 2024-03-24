# Set up Safari for development
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write -g WebKitDeveloperExtras -bool true

# Set up screen corners to do actions
defaults write com.apple.dock wvous-bl-corner -int 11 # Launchpad
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 4 # Desktop
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-tl-corner -int 2 # Mission Control
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 12 # Notification Center
defaults write com.apple.dock wvous-tr-modifier -int 0

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
