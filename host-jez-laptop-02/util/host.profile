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
# export MANPATH="/Library/Developer/CommandLineTools/usr/share/man:$MANPATH"
# export MANPATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/share/man:$MANPATH"

# Use GNU coreutils with their actual names
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"

# Tmux
# export MANPATH="/opt/homebrew/opt/tmux/share/man:$MANPATH"

# Add diff-highlight from Git contrib
export PATH="$PATH:/opt/homebrew/opt/git/share/git-core/contrib/diff-highlight"

export PATH="$PATH:./node_modules/.bin"

export PATH="$PATH:$HOME/.local/bin"

# Globally installed yarn executables
# export PATH="$PATH:$HOME/.yarn/bin"
# export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"

# Find clangd from Homebrew, but put it last (fallback)
# export PATH="$PATH:$(brew --prefix)/opt/llvm/bin"

if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
fi
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
  rbenv rehash
fi
