# Login PATH setup, read via ~/.profile by both bash and zsh. Lives here rather
# than in .zshenv or host.sh because macOS's /etc/profile and /etc/zprofile run
# path_helper first, which moves the system directories (/usr/bin/ruby,
# /usr/bin/git, ...) ahead of everything set before it.

# ----- PATH and MANPATH ------------------------------------------------------

# Homebrew again, since path_helper moved it behind /usr/bin.
if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
fi

# Catalina
export MANPATH="/Library/Developer/CommandLineTools/usr/share/man:$MANPATH"
export MANPATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$MANPATH"

# Use GNU coreutils with their actual names
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Tmux
export MANPATH="/opt/homebrew/opt/tmux/share/man:$MANPATH"

# Use bison from Homebrew
export PATH="/usr/local/opt/bison/bin:$PATH"
export PATH="/opt/homebrew/opt/bison/bin:$PATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight"
export PATH="$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"
export PATH="$PATH:/usr/local/sbin"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/stripe/bin"

# Globally installed yarn executables
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# We're using thrift0.9 at Stripe
export PATH="$PATH:/opt/homebrew/opt/thrift@0.9/bin"

# Find clangd from Homebrew, but put it last (fallback)
export PATH="$PATH:$HOMEBREW_PREFIX/opt/llvm/bin"

# For gcloud command, to deploy srb.help
export PATH="$PATH:/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/bin"

# This works, but I have no use for pyenv shims at the moment, so disabling to make things faster
# if command -v pyenv &> /dev/null; then
#   export PATH="$(pyenv root)/shims:$PATH"
#   pyenv rehash
# fi
# ----- From Stripe IT department ---------------------------------------------

export PATH="$HOME/stripe/henson/bin:$PATH"
export PATH="$PATH:$HOME/stripe/space-commander/bin"
source "$HOME/.rbenvrc"
# source ~/.stripe-repos.sh
# eval "$(nodenv init -)"

# Added by Toolbox App
export PATH="$PATH:/Users/jez/Library/Application Support/JetBrains/Toolbox/scripts"
