
# Use Vim as the system-wide editor
export EDITOR="vim"

# Load LS_COLORS
eval $(dircolors ~/.dircolors)
# now, when we us `ls` we'll get solarized-colored files and directories!

# Turn on italics
tic ~/.xterm-256color-italic.terminfo
export TERM=xterm-256color-italic
# Things will break if you don't have these terminfo changes applied on _every_
# host that you use; i.e., every box that you ssh into
