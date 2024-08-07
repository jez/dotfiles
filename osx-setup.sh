#!/usr/bin/env bash
# =========================================================================== #
#                                                                             #
#  osx-setup.sh                                                               #
#                                                                             #
#  Author:  Jake Zimmerman                                                    #
#  Email:   jake@zimmerman.io                                                 #
#                                                                             #
# This is a script designed to be run on a fresh OS X installation.           #
# It has yet to be tested, though it is an accurate transcription of          #
# I just ran when setting up my OS X installation after a clean re-install.   #
#                                                                             #
# You may want to run the individual commands manually, instead of as a       #
# script. In fact, in it's current state, it calls `exit` halfway through     #
# and doesn't finish.                                                         #
#                                                                             #
# TODO:                                                                       #
#   - Utilize Homebrew Cask to install actual apps.                           #
#                                                                             #
# =========================================================================== #

# Install Xcode tools
xcode-select --install
# Note: MacVim (and possibly smlnj I'm not quite sure) require a full-blown
# Xcode installation to work

# Install and set up Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

# Set up PATH until we clone our dotfiles
# Not necessary on OS X 10.10 (Yosemite)
export PATH="/usr/local/bin:$PATH"

# Install iTerm2
brew cask install iterm2

# Install and setup git
brew install git

# Install Hub for convenience before we start doing Git commands
brew install hub

# Install newest bash and zsh and make zsh the login shell
brew install bash
brew install bash-completion
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells

# (you do actually want to still do this btw)
brew install zsh
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"

# Install gnu coreutils
brew install coreutils
# Note: my bash_profile allows these commands to be run without prefixes

# Install newest vim
brew install vim

# Set up dotfiles
brew install rcm

# TODO(jez) Document how to set up all the ssh keys you need
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# On Stripe machines:
vim ~/.ssh/config
# comment out the `Host *` section

# If you are not Jake Zimmerman, you will want to fork this repo first
hub clone --recursive jez/dotfiles ~/.dotfiles
cd ~/.dotfiles
# Make sure we use correct rcrc, as there will be no ~/.rcrc yet
RCRC="./rcrc" rcup
# or for Stripe laptops:
RCRC="./rcrc" rcup -B st-jez1 -d ~/stripe/dotfiles
cd -

# Set up host-specific (git, sh, zsh, etc.)
# The best way to do this is to look at MacBook Air, Dropbox, & Stripe manually
# Files you'll almost certainly need in some form:
#   gitignore, gitconfig, host.sh, host.zsh
# You may also want to look at:
#   ssh/config


# Now that dotfiles have been installed, exit and re-open iTerm2
exit

# Set up iTerm2
#
# Load preferences from folder (choose: ~/.dotfiles)
# Install Iosevka Fixed
#   https://github.com/be5invis/Iosevka/blob/master/doc/PACKAGE-LIST.md#packaging-formats
# Install Menlo for Powerline (from ~/.dotfiles/fonts/)

# Download and import iTerm colors
git clone https://github.com/mbadolato/iTerm2-Color-Schemes ~/Desktop/iTerm2-Color-Schemes
open ~/Desktop/iTerm2-Color-Schemes/schemes/
# Import whichever you'd like by selecting and pressing Cmd + O

# Use iTerm2 settings file by going to preferences and selecting to load
# preferences from a folder: ~/.dotfiles

# Install neovim
brew tap neovim/neovim
brew install neovim
ln -s ~/.vim ~/.config/nvim
python3 -m pip install pynvim --break-system-packages

# Install fzf
brew install fzf fd
/usr/local/opt/fzf/install
mkrc -o ~/.fzf.zsh
rm ~/.fzf.bash

# Install ruby
brew install rbenv
brew install ruby-build

# Other utilities
brew install --cask alfred
brew install --cask hammerspoon
brew install --cask karabiner-elements

brew cask install google-chrome
brew cask install google-drive
brew cask install dropbox
brew cask install spotify
brew cask install amethyst
brew cask install inskape
brew cask install calibre
brew cask install fitbit-connect
brew cask install rcdefaultapp
brew cask install flux

# Install python
brew install python
brew install python3

# Install node
brew install node

# Helper utilities
brew install tree
brew install wget
brew install tmux
brew install htop
brew install ctags
brew install imagemagick
brew install watch
brew install rlwrap

# After installing Xcode
# TODO install Xcode using script
sudo xcodebuild -license

# Install MacVim
brew install macvim
brew linkapps
# You may want to install RCDefaultApps to deal with using MacVim for opening
# text files

# Install smlnj
brew install smlnj

# After installing python

# Install virtualenvwrapper
pip install virtualenvwrapper
# Note: requires relaunching the terminal to work

# Helper utilities
pip install grip

# After installing node
npm install -g jade

# GUI Settings
# TODO: Automate this

# System Preferences
#   - General
#     - Use dark menubar and doc
#   - Desktop & Screen Saver
#     - Desktop
#       - Source: Pokemon
#         - Change picture: when logging in
#     - Screen Saver
#       - Classic
#         - Source: Pokemon
#         - Shuffle slide order
#       - Hot Corners...
#         - Bottom left: Start Screen Saver
#   - Dock
#     - Automatically hide and show the dock
#     - Show suggested and recent apps in Dock
#     - Click wallpaper to reveal desktop > Only in Stage Manager
#   - Mission Control
#     - no Automatically rearrange spaces based on recent use
#     - Dashboard: As Space
#   - if on MacBook Pro:
#     - Displays
#       - Display
#         - Looks like 1680 x 1050
#       - No Automatically adjust brightness
#   - Trackpad
#     - Point & Click
#       - Tap to click
#   - Date & Time
#     - Clock
#       - Show date
#   - Accessibility
#     - Zoom
#       - Use scroll gesture with modifier keys to zoom
#       - Unckeck "Smooth images"
#     - Trackpad Options...
#       - Enable dragging
#     - Display
#       - Unckeck "Shake mouse pointer to locate"
#   - Sound
#     - Sound Effects
#       - Play feedback when volume is changed
#   - Keyboard
#     - Keyboard
#       - Key repeat
#         - Fast
#       - Delay until repeat
#         - Short
#       - Touch Bar shows: Expanded Control Strip
#       - Modifier Keys...
#         - Swap Caps to Ctrl
#       - Show keyboard and emoji viewers in menu bar
#       - Add Japanese - Romanji
#       - Automatically switch to a document's input source
#       - No Correct spelling automatically
#       - No Capitalize words automatically
#       - No Add period with double-space
#     - Shortcuts
#       - Mission Control
#         - Mission Control
#           - Move left a space: Option + Shift + [
#           - Move right a space: Option + Shift + ]
#       - Spotlight
#         - Show Spotlight search: Option + Space
#           - Don't forget to install alfred and change to Command + Space
#       - Accessibility
#         - Invert colors
#       - App Shortcuts
#         - Google Chrome.app
#           - Add
#             - "Select Next Tab"
#             - Cmd + Option + ]
#             - "Select Previous Tab"
#             - Cmd + Option + [
#         - Sketch.app
#           - Add
#             - "ArtboardZoom - Zoom to selected Artboard"
#             - Ctrl + Space
#             - "Show Smart Guides"
#             - Cmd + R

# Alfred
#   - General
#     - Alfred Hotkey
#       - Command + Space
#   - Appearance
#     - Theme
#       - OS X Yosemite Dark
#     - Options
#       - Hide hat on Alfred window

# Desktop
#   - Sort By
#     - Snap to Grid

# Menu Bar
#   - Battery Icon
#     - Show Percentage

# Spotify
#   - View
#     - Uncheck "Right sidebar"

# Finder
#   - General
#     - New Finder windows show
#       - $HOME
#   - Advanced
#     - Show all filename extensions
#     - no Show warning before changing an extension
#   - Favorites
#     - Desktop
#     - Documents
#     - Dropbox
#     - Screenshots
#     - Applications
#     - Home
#   - Sort By:
#     - View > [hold Option] Sort by ... > Name

# Downloads
#   - Remove Downloads, symlink to Desktop

# ~/
#  bin -> stripe/bin
#  blog -> stripe/github/blog
#  jez-notes
#  sorbet

# Chrome
#
# - Right click on URL bar, "Always Show Full URls"
# - Transfer Chrome history
#   - `zip -r ~/Desktop/chrome-history.zip ~/Library/Application\ Support/Google/Chrome/Default/History`
#   - `scp ~/Desktop/chrome-history.zip st-jez5.local:Desktop`
#   - `ssh st-jez5.local`
#   - `unzip chrome-history.zip`
#   - `mv ~/Library/Application\ Support/Google/Chrome/Default/History ~/Desktop/chrome-history.bak`
# - Setting up personal laptop?
#   - Sign into personal Chrome. Done.
# - Setting up work laptop?
#   - Copy these from personal account:
#     - chrome://settings
#     - chrome://extensions
#     - Enable keyboard shortcuts for Inbox
#     - Stylebot settings

# Messages
#
# - Add iCloud account
# - Be sure to sync contacts from Google account (not iCloud)
# - Google when you need help
# - Messages > Settings > iMessage
#   - check "Enable Messages in iCloud" and then click Sync Now

# VS Code
#
# code --install-extension ginfuru.ginfuru-better-solarized-dark-theme && \
#     code --install-extension vscodevim.vim && \
#     code --install-extension ms-vscode.cpptools && \
#     code --install-extension sorbet.sorbet-vscode-extension && \
#     code --install-extension orta.vscode-jest && \
#     code --install-extension usernamehw.errorlens
# defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
#
# Global settings
#
# defaults write -g ApplePressAndHoldEnabled -bool false
#
# https://apple.stackexchange.com/questions/465132/how-do-i-turn-off-macos-sonomas-emoji-guessing
# sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool NO

