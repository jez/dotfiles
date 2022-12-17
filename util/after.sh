
# Hacks to get things to work

# The following line was originally in ~/.util/misc.zsh
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

export TMUXLINE_ACCENT_COLOR="${TMUXLINE_ACCENT_COLOR:-colour2}"

# ensure that these directories are available to us
if [ "$LOCAL_PATH" = "" ]; then
  export LOCAL_PATH=".:$HOME/bin:/usr/local/bin:$HOME/.local/bin"
  export PATH="$LOCAL_PATH:$PATH"
fi
