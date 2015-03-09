typeset -U path

fpath=( "$HOME/.zfunctions" $fpath )

# Load host-specific zshenv configurations
[ -f ~/.util/host.zshenv ] && source ~/.util/host.zshenv
