
# Use Vim as the system-wide editor
if which nvim &> /dev/null; then
  export EDITOR="nvim"
else
  export EDITOR="vim"
fi

# Load LS_COLORS
which dircolors &> /dev/null && eval $(dircolors ~/.dircolors)
# now, when we us `ls` we'll get solarized-colored files and directories!

# Turn on italics
if echo $TERM | grep 'tmux' &> /dev/null; then
  tic ~/.tmux-256color.terminfo
elif echo $TERM | grep 'xterm' &> /dev/null; then
  tic ~/.xterm-256color.terminfo
else
  export TERM=xterm-256color
fi
# Things will break if you don't have these terminfo changes applied on _every_
# host that you use; i.e., every box that you ssh into
