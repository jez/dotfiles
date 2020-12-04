#!/bin/bash

# ----- local -----

set -euo pipefail

pay sync --no-sync-loop "$HOME/stripe/dotfiles":/home/jez/.dotfiles

# ----- remote -----

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew tap thoughtbot/formulae
brew install rcm

cd ~/.dotfiles
RCRC=./rcrc rcup -B qa-mydev
# overwrite .profile

brew install neovim
ln -s ~/.vim ~/.config/nvim
cd ~/.vim/bundle/LanguageClient-neovim
bash install.sh
cd -

brew install fzf
/home/linuxbrew/.linuxbrew/opt/fzf/install --completion --key-bindings --no-update-rc

mkdir -p "$HOME/.local/bin"

curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/rg'

curl -fsSL https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-v8.1.1-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/fd'

