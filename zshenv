# Ignore duplicates in zsh arrays
typeset -U path

# This is a zsh array. It contains the locations where functions can be defined
# (it's like PATH, but for functions). See man zshparam for more info.
fpath=( "$HOME/.zfunctions" $fpath )

# Load host-specific zshenv configurations
[ -f ~/.util/host.zshenv ] && source ~/.util/host.zshenv
