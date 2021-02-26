# Ignore duplicates in zsh arrays
typeset -U path

# This is a zsh array. It contains the locations where functions can be defined
# (it's like PATH, but for functions). See man zshparam for more info.
fpath=( "$HOME/.zfunctions" $fpath )

# From https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# if command -v brew &> /dev/null; then
#   fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
# fi

# Load host-specific zshenv configurations
[ -f ~/.util/host.zshenv ] && source ~/.util/host.zshenv
