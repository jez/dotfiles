#!/usr/bin/env bash

# Credit to mathiasbynens who I took some things from
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

set -euo pipefail

# Put downloads on the Desktop instead of the Downloads folder
sudo rmdir Downloads
ln -s Desktop Downloads

# Desktop & Dock
# Dock > Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Dock > Show suggested and recent apps in Dock
defaults write com.apple.dock show-recents -bool false
# Mission Control > Automatically rearrange spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Desktop & Stage Manager > Click wallpaper to reveal desktop
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Wipe all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array
# Wipe all other persistent things from the Dock
defaults write com.apple.dock persistent-other -array

killall Dock

# Desktop (actual)
# Sort By > Snap to Grid
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# View > [hold Option] > Sort by... > Date Modified
/usr/libexec/PlistBuddy -c "Set :StandardViewOptions:ColumnViewOptions:ArrangeBy modd" ~/Library/Preferences/com.apple.finder.plist

# New Finder windows show $HOME
defaults write com.apple.finder NewWindowTarget PfHm

# Finder > Advanced > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder > Advanced > Show warning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Finder > Use column view by default
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

killall Finder

# Trackpad > Point & Click > Tap to click
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Accessibility > Vision > Display > Pointer > Shake mouse pointer to locate
defaults write NSGlobalDomain CGDisableCursorLocationMagnification -bool false

# Sound > Sound Effects > Play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 1

# Keyboard > Key repeat rate > Fast
defaults write NSGlobalDomain InitialKeyRepeat -float 15
# Keyboard > Delay until repeat > Short
defaults write NSGlobalDomain KeyRepeat -float 2

# Keyboard > Text Input > Input Sources > Edit > Automatically switch to a document's input source
defaults write com.apple.HIToolbox AppleGlobalTextInputProperties -dict-add "TextInputGlobalPropertyPerContextInput" -bool true
# Keyboard > Text Input > Input Sources > Edit > Correct spelling automatically
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
# Keyboard > Text Input > Input Sources > Edit > Capitalize words automatically
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
# Keyboard > Text Input > Input Sources > Edit > Add period with double space
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Accessibility > Motor > Pointer Control > Trackpad Options... > Use trackpad for dragging
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true

defaults write -g ApplePressAndHoldEnabled -bool false

# https://apple.stackexchange.com/questions/465132/how-do-i-turn-off-macos-sonomas-emoji-guessing
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool false

osascript <<EOF
tell application "System Events"
    make login item at end with properties { path: "/Applications/Amethyst.app" }
end tell
EOF


