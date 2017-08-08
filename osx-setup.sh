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
brew install zsh
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"

# Install gnu coreutils
brew install coreutils
# Note: my bash_profile allows these commands to be run without prefixes

# Install newest vim
brew install vim

# Set up dotfiles
brew tap thoughtbot/formulae
brew install rcm
# If you are not Jake Zimmerman, you will want to fork this repo first
hub clone --recursive jez/dotfiles ~/.dotfiles
cd ~/.dotfiles
# Make sure we use correct rcrc, as there will be no ~/.rcrc yet
RCRC="./rcrc" rcup
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
# Install Menlo for Powerline (from ~/.dotfiles/fonts/)

# Download and import iTerm colors
git clone https://github.com/mbadolato/iTerm2-Color-Schemes ~/Desktop/iTerm2-Color-Schemes
open ~/Desktop/iTerm2-Color-Schemes/schemes/
# Import whichever you'd like by selecting and pressing Cmd + O

# Use iTerm2 settings file by going to preferences and selecting to load
# preferences from a folder: ~/.dotfiles

# Install neovim for the lulz
brew tap neovim/neovim
brew install neovim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install fzf
brew install fzf
/usr/local/opt/fzf/install
mkrc -o ~/.fzf.zsh
rm ~/.fzf.bash

# Install ruby
brew install rbenv
brew install ruby-build
echo "rbenv is insatlled."
echo "You'll still have to install ruby 1.9.3 for Octopress."
cat << EOF
(within Octopress project root directory)
$ rbenv install 1.9.3-p0
$ rbenv local 1.9.3-p0
$ rbenv rehash
EOF
echo "http://octopress.org/docs/setup/rbenv/"

# Other utilities
brew cask install alfred
brew cask alfred
brew cask install google-chrome
brew cask install google-drive
brew cask install dropbox
brew cask install spotify
brew cask install amethyst
brew cask install inskape
brew cask install calibre
brew cask install fitbit-connect
brew cask install rcdefaultapp

# Install python
brew install python
brew install python3

# Install node
brew install node

# Helper utilities
brew install tree
brew install wget
brew install ack
brew install tmux
brew install htop
brew install ctags
brew install gist
brew install heroku-toolbelt
brew install imagemagick
brew install watch
brew install rlwrap
brew install icdiff

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
#   - Mission Control
#     - no Automatically rearrange spaces based on recent use
#     - Dashboard: As Space
#   - if on MacBook Pro:
#     - Display
#       - Display
#         - Looks like 1680 x 1050
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
#     - Shortcuts
#       - Mission Control
#         - Mission Control
#           - Move left a space: Option + Shift + [
#           - Move right a space: Option + Shift + ]
#       - Spotlight
#         - Show Spotlight search: Ctrl + Space
#           - Don't forget to install alfred and change to Command + Space
#       - Accessibility
#         - Invert colors
#       - App Shortcuts
#         - Spotify.app
#           - Add
#             - "Toggle Fullscreen"
#             - Ctrl + Command + F
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

# Chrome
#
# - Setting up personal laptop?
#   - Sign into personal Chrome. Done.
# - Setting up work laptop?
#   - Copy these from personal account:
#     - chrome://settings
#     - chrome://extensions
#     - Enable keyboard shortcuts for Inbox
#     - Vimium settings
#     - Stylebot settings

# Messages
#
# - Add iCloud account
# - Be sure to sync contacts
# - Google when you need help
