#!/bin/sh

## README
# /!\ This installation script is designed for my OWN use.
#     Do not run it without checking each command!

# Inspirations:
# https://github.com/nicolinuxfr/macOS-post-installation
# https://www.macg.co/logiciels/2017/02/comment-synchroniser-les-preferences-des-apps-avec-mackup-97442
# https://github.com/OzzyCzech/dotfiles/blob/master/.osx

echo "Asking the the administrator password upfront"
sudo -v

# Keep-alive: updates the `sudo` timestamp until `post-install.sh` is finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

if test ! "$(which brew)"
then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Adding Homebrew binaries to the PATH"
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Update the list of applications available with Homebrew"
brew update

echo "Installing Synology Drive first to start settings synchronization"
brew install synology-drive

echo "Running Synology Drive"
echo "ℹ️ Personal folder (in which Mackup is) should be '~/Synology/Personnel/'"
open -a "Synology Drive Client"

echo "Installing most applications with Homebrew and Mac App Store CLI"
brew bundle

# Allow certain applications to be launched despite the quarantine
# TODO: update the list with all applications requiring this
sudo xattr -dr com.apple.quarantine /Applications/Firefox.app
sudo xattr -dr com.apple.quarantine /Applications/Google\ Chrome.app
sudo xattr -dr com.apple.quarantine /Applications/iTerm.app
sudo xattr -dr com.apple.quarantine /Applications/Visual\ Studio\ Code.app

echo "Installation of Node development tools"
npm install -g npm-check-updates

# -----------------------------------------------------------------------------
# Configuration
# -----------------------------------------------------------------------------

echo "Setting some default parameters"

# Close "System Preferences" windows
osascript -e 'tell application "System Preferences" to quit'

# FINDER

# Displaying the Library folder (hidden by default)
chflags nohidden ~/Library

# Displaying the sidebar
defaults write com.apple.finder ShowStatusBar -bool true

# Default display in column mode
# Flwv ▸ Cover Flow View
# Nlsv ▸ List View
# clmv ▸ Column View
# icnv ▸ Icon View
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show access path
defaults write com.apple.finder ShowPathbar -bool true

# Display all file extensions
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show home folder as default in new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Delete duplicates in the "Open with..." menu
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Search in current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Full save window by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Full print window by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Do not alert if file extension is modified
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# No creation of .DS_STORE files on network and external disks
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Remove application quarantine alert
# defaults write com.apple.LaunchServices LSQuarantine -bool false

## DOCK

# Minimum size
defaults write com.apple.dock tilesize -int 32

# Active magnification
defaults write com.apple.dock magnification -bool true

# Maximum size for magnification
defaults write com.apple.dock largesize -float 128

# Accelerated opening
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.4

## MISSION CONTROL

# No organization of desktops according to open apps
defaults write com.apple.dock mru-spaces -bool false

# Password requested immediately when screen saver activates
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

## ACTIVE CORNERS

#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left: desktop
# defaults write com.apple.dock wvous-tl-corner -int 4
# defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right: screensaver
defaults write com.apple.dock wvous-tr-corner -int 5
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left: application windows
# defaults write com.apple.dock wvous-bl-corner -int 3
# defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right: Mission Control
# defaults write com.apple.dock wvous-br-corner -int 2
# defaults write com.apple.dock wvous-br-modifier -int 0

## KEYBOARD AND TRACKPAD

# Enable full keyboard access for all controls (enable Tab in modal dialogs)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
sudo defaults write -g ApplePressAndHoldEnabled -bool false

# Set fast keyboard repeat rate
sudo defaults write NSGlobalDomain KeyRepeat -int 1
sudo defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Enable tap to click on Trackpad
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
sudo defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# To drag a window from anywhere, not just the top bar, with ^ + Cmd
defaults write -g NSWindowShouldDragOnGesture -bool true

## APPS

# Check availability of updates daily
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Check for updates automatically
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Safari: enable the Develop menu and the Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Safari: show the status bar
defaults write com.apple.safari ShowOverlayStatusBar -int 1

# Safari: show the full URL in the address bar (note: this will still hide the scheme)
defaults write com.apple.safari ShowFullURLInSmartSearchField -int 1

# Safari: do not track
defaults write com.apple.safari SendDoNotTrackHTTPHeader -int 1

# Safari: show bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool true

# Disable back gesture
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
defaults write org.mozilla.firefox AppleEnableSwipeNavigateWithScrolls -bool FALSE
defaults write com.apple.Safari AppleEnableSwipeNavigateWithScrolls -bool FALSE

# Photos: no display for iPhones
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool YES

# TextEdit: .txt as default extension
defaults write com.apple.TextEdit RichText -int 0

# TextEdit: open and save files in UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

## iTerm2: do not display a closing alert
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

## SOUND

# Silent start
sudo nvram SystemAudioVolume="%00"

# Audible alerts when the volume is changed
sudo defaults write com.apple.systemsound com.apple.sound.beep.volume -float 1

## IMAGES

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Enable shadows in screenshots
defaults write com.apple.screencapture disable-shadow -bool false

echo "Restarting Finder and Dock. You'll need to restart the computer to complete."
killall Dock
killall Finder

echo "Cleaning…"
brew cleanup
rm -f -r /Library/Caches/Homebrew/*

echo ""
echo "ET VOILÀ !"
echo "Once you have synchronized your Synology Drive data (initially only the "Mackup" and "Settings" folders are required), run the post-cloud.sh script"
