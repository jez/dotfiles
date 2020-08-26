#!/bin/bash
set -euo pipefail

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
echo "$(brew --prefix)/bin/zsh" | sudo tee -a /etc/shells
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
