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

if ! [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
  echo 'Installing homebrew'
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

set -x

# Fix zsh compinit warning:
#     zsh compinit: insecure directories, run compaudit for list
chmod -R 755 /home/linuxbrew/.linuxbrew/share/zsh
chmod -R 755 /home/linuxbrew/.linuxbrew/share/zsh/site-functions

brew tap thoughtbot/formulae
brew install rcm

mkdir -p "$HOME/.local/bin"

curl -fsSL https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/rg'

curl -fsSL https://github.com/sharkdp/fd/releases/download/v10.1.0/fd-v10.1.0-x86_64-unknown-linux-musl.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local/bin" -xvz '*/fd'

curl -fsSL https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux64.tar.gz | tar --wildcards --strip-components 1 -C "$HOME/.local" -xzv

install_cmd=(install)
if [ "$(uname -m)" = "aarch64" ]; then
  install_cmd+=(--build-from-source)
fi

brew "${install_cmd[@]}" fzf
brew "${install_cmd[@]}" git
brew "${install_cmd[@]}" zsh
brew "${install_cmd[@]}" tmux
brew "${install_cmd[@]}" fastmod
brew "${install_cmd[@]}" hub

cp /etc/gitconfig /pay/home/linuxbrew/.linuxbrew/etc/gitconfig

cd ~/.dotfiles
RCRC=./rcrc rcup -f -B qa-mydev
# -f to overwrite .profile

cd ~/.vim/bundle/LanguageClient-neovim
bash install.sh
cd -

ln -s ~/.vim ~/.config/nvim
/home/linuxbrew/.linuxbrew/opt/fzf/install --completion --key-bindings --no-update-rc

# TODO(jez) Figure out where to put pay configure --no-pay-up-emoji
