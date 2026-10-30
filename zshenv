# Ignore duplicates in zsh arrays
typeset -U path fpath

# Environment needed by every zsh invocation, including zsh -c and SSH commands.
[ -f ~/.util/homebrew.sh ] && source ~/.util/homebrew.sh

# This is a zsh array. It contains the locations where functions can be defined
# (it's like PATH, but for functions). See man zshparam for more info.
fpath=( "$HOME/.zfunctions" $fpath )

# Keep Homebrew first even when its environment was inherited. The unique path
# array moves existing entries without duplicating them.
if [ -n "${HOMEBREW_PREFIX:-}" ]; then
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)

  # Make Homebrew completions available before compinit runs in .zshrc.
  fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

# Load host-specific zshenv configurations
[ -f ~/.util/host.zshenv ] && source ~/.util/host.zshenv
