
# hacks to run before everything else

# greatwhite.ics.cs.cmu.edu is far too old for anything I'd want to do
[[ $(hostname) =~ greatwhite ]] && exit

# set XDG Base Directories appropriately
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

if [ -d /home/linuxbrew/.linuxbrew ] && [ "$HOMEBREW_PREFIX" = "" ]; then
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

# Set global Solarized dark/light toggle
export SOLARIZED="light"
