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
# script.                                                                     #
#                                                                             #
# =========================================================================== #

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install git hub coreutils rcm neovim fzf fd tree rg fastmod tmux tree wget htop ctags watch
brew install --cask iterm2 spotify firefox karabiner-elements maestral
brew install --cask amethyst tailscale

# (you do actually want to still do this btw)
brew install zsh
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"

# Generate an SSH key so you can add it to GitHub
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
ssh-keygen -t ed25519 -C zimmerman.jake@gmail.com -f ~/.ssh/id_ed25519 -N ""
cat >> ~/.ssh/config <<EOF
Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
EOF
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
open https://github.com/settings/keys

git clone git@github.com:jez/bin.git ~/bin

git clone --recursive git@github.com:jez/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
# Make sure we use correct rcrc, as there will be no ~/.rcrc yet
RCRC="./rcrc" rcup
ln -s ~/.vim ~/.config/nvim
# or for Stripe laptops:
RCRC="./rcrc" rcup -B st-jez1 -d ~/stripe/dotfiles
cd -

open -a Amethyst.app

# Install Iosevka Fixed
#   https://github.com/be5invis/Iosevka/blob/master/doc/PACKAGE-LIST.md#packaging-formats

# Set up host-specific (git, sh, zsh, etc.)
# The best way to do this is to look at MacBook Air, Dropbox, & Stripe manually
# Files you'll almost certainly need in some form:
#   gitignore, gitconfig, host.sh, host.zsh
# You may also want to look at:
#   ssh/config

# Set up iTerm2
#
# Load preferences from folder (choose: ~/.dotfiles)

# ----- Non essential ---------------------------------------------------------

# On Stripe machines:
vim ~/.ssh/config
# comment out the `Host *` section
# TODO(jez) Did we get rid of the ~/.ssh/config? Do I need this still? Is it in a different file I need to edit?

# Install newest bash and zsh and make zsh the login shell
brew install bash
brew install bash-completion
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells

# Install ruby
brew install rbenv

# Other utilities
brew install --cask alfred hammerspoon calibre
# brew cask install rcdefaultapp

# Install neovim
python3 -m pip install pynvim --break-system-packages

# System Preferences
#   - Keyboard
#     - Keyboard
#       - Show keyboard and emoji viewers in menu bar
#       - Add Japanese - Romanji
#     - Keyboard Shortcuts...
#       - Mission Control
#         - Mission Control
#           - Move left a space: Option + Shift + [
#           - Move right a space: Option + Shift + ]
#       - Spotlight
#         - Show Spotlight search: Option + Space
#           - Don't forget to install alfred and change to Command + Space

# Alfred
#   - General
#     - Alfred Hotkey
#       - Command + Space
#   - Appearance
#     - Theme
#       - OS X Yosemite Dark
#     - Options
#       - Hide hat on Alfred window

# Finder
#   - Favorites
#     - Home
#     - Desktop
#     - Dropbox
#     - Applications

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
