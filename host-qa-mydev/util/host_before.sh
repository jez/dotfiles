
if [ -d /home/linuxbrew/.linuxbrew ] && [ "$HOMEBREW_PREFIX" = "" ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi
