
# Hacks to get things to work

# The following line was originally in ~/.util/misc.zsh
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

export TMUXLINE_ACCENT_COLOR="${TMUXLINE_ACCENT_COLOR:-colour2}"
