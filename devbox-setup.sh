#!/bin/bash

set -euo pipefail

if ! [[ $(hostname) =~ qa-mydev* ]]; then
  # ----- local -----

  pay sync --no-sync-loop "$HOME/stripe/dotfiles":/home/jez/.dotfiles

  pay ssh 'cd /home/jez/.dotfiles && ./devbox-setup.sh'

  exit
fi

# ----- remote -----

(
cd /pay/src/pay-server
git config user.email jez@stripe.com
git config core.commitGraph true
git commit-graph write --reachable
)

echo 'Fixing /pay/home mount point for Linuxbrew'

sudo unlink /home
sudo mkdir /home
sudo mount --bind /pay/home /home
echo "/pay/home /home none bind 0 0" | sudo tee -a /etc/fstab

echo 'Installing homebrew'

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
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


mkdir -p "$HOME/.local/bin"

curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/rg'

curl -fsSL https://github.com/sharkdp/fd/releases/download/v8.4.0/fd-v8.4.0-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/fd'

curl -fsSL https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local" -xzv
# brew install neovim
ln -s ~/.vim ~/.config/nvim

brew install fzf
/home/linuxbrew/.linuxbrew/opt/fzf/install --completion --key-bindings --no-update-rc

brew install git
cp /etc/gitconfig /pay/home/linuxbrew/.linuxbrew/etc/gitconfig
brew install zsh
brew install --HEAD tmux

# TODO(jez) Figure out where to put pay configure --no-pay-up-emoji
