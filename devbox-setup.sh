#!/bin/bash

set -euo pipefail

if ! [[ $(hostname) =~ qa-mydev* ]]; then
  # ----- local -----

  pay sync --no-sync-loop "$HOME/stripe/dotfiles":/home/jez/.dotfiles

  pay ssh 'cd /home/jez/.dotfiles && ./devbox-setup.sh'

  exit
fi

# ----- remote -----

echo 'Installing homebrew'

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# I tried mucking with the Homebrew source files for linux to get around the
# bottle problem (/home -> /pay/home symlink) but
# - brew aggressively tries to reset the state to a clean `stable` branch
# - it ignores `--force-bottle` if the absolute path doesn't match
# - when I force it by setting HOMEBREW_SIMULATE_FROM_CURRENT_BRANCH=1, there
#   was a NoMethodError raised from Homebrew

set -x

# Fix zsh compinit warning:
#     zsh compinit: insecure directories, run compaudit for list
chmod -R 755 /pay/home/linuxbrew/.linuxbrew/share/zsh
chmod -R 755 /pay/home/linuxbrew/.linuxbrew/share/zsh/site-functions

brew tap thoughtbot/formulae
brew install rcm

cd ~/.dotfiles
RCRC=./rcrc rcup -f -B qa-mydev
# -f to overwrite .profile

cd ~/.vim/bundle/LanguageClient-neovim
bash install.sh
cd -

brew install fzf
/home/linuxbrew/.linuxbrew/opt/fzf/install --completion --key-bindings --no-update-rc

brew install tmux

mkdir -p "$HOME/.local/bin"

curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep-12.1.1-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/rg'

curl -fsSL https://github.com/sharkdp/fd/releases/download/v8.1.1/fd-v8.1.1-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/fd'

curl -fsSL https://github.com/neovim/neovim/releases/download/v0.4.4/nvim-linux64.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local" -xzv
# brew install neovim
ln -s ~/.vim ~/.config/nvim
