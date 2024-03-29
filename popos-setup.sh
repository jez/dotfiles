#!/bin/bash
# =========================================================================== #
#                                                                             #
#  popos-setup.sh                                                             #
#                                                                             #
#  Author:  Jake Zimmerman                                                    #
#  Email:   jake@zimmerman.io                                                 #
#                                                                             #
# This is a list of commands to be run on a fresh Pop!_OS installation.       #
# It is not meant to be run as a script.                                      #
# Run these command manually, in case something has changed.                  #
#                                                                             #
# =========================================================================== #
set -euo pipefail
exit

# -- on laptop, not on Desktop --
ssh-copy-id -i ~/.ssh/id_rsa.pub jez@jez-pc-01

# Homebrew on Linux -> https://docs.brew.sh/Homebrew-on-Linux
# installed into `/home/linuxbrew/.linuxbrew`

sudo apt-get install build-essential
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# SSH setup
ssh-keygen -t rsa -b 4096 -C "zimmerman.jake@gmail.com"
# then -> https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account

# dotfiles
git clone --recursive git@github.com:jez/dotfiles.git ~/.dotfiles

# rcm
brew tap thoughtbot/formulae
brew install rcm

cd ~/.dotfiles
RCRC=./rcrc rcup
# overwrite .bashrc
# overwrite .profile

# zsh
brew install zsh
# should already be in /etc/shells, but if not:
# echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
chsh -s "$(brew --prefix)/bin/zsh"

# neovim
brew install neovim
ln -s ~/.vim ~/.config/nvim
cd ~/.vim/bundle/LanguageClient-neovim
bash install.sh
cd -

# fzf
brew install fzf
/home/linuxbrew/.linuxbrew/opt/fzf/install --completion --key-bindings --no-update-rc

# utilities
brew install rg
brew install fd
brew install tmux
