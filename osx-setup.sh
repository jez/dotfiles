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

# Install and setup git
brew install git
git config --global user.name "Jacob Zimmerman"
git config --global user.email "zimmerman.jake@gmail.com"
git config --global color.ui true
git config --global push.default simple
git config --global credential.helper osxkeychain

# Install newest bash and zsh and make zsh the login shell
brew install bash
brew install bash-completion
echo "`brew --prefix`/bin/bash" | sudo tee -a /etc/shells
brew install zsh
echo "`brew --prefix`/bin/zsh" | sudo tee -a /etc/shells
chsh -s "`brew --prefix`/bin/zsh"

# Install gnu coreutils
brew install coreutils
# Note: my bash_profile allows these commands to be run without prefixes

# Install newest vim
brew install vim

# Set up dotfiles
brew tap thoughtbot/formulae
brew install rcm
# If you are not Jake Zimmerman, you will want to fork this repo first
git clone https://github.com/jez/dotfiles ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
# Make sure we use correct rcrc, as there will be no ~/.rcrc yet
RCRC="./rcrc" rcup
cd -

# Now that dotfiles have been installed, exit and re-open iTerm2
exit
# TODO repoen iTerm2

# Download and import iTerm colors
git clone https://github.com/mbadolato/iTerm2-Color-Schemes ~/Desktop/iTerm2-Color-Schemes
open ~/Desktop/iTerm2-Color-Schemes/schemes/*itermcolors
# Be sure to change the location to load iTerm config defaults from

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

# Install Homebrew Cask
brew install caskroom/cask/brew-cask

# Install iTerm2
brew cask install iterm2

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
