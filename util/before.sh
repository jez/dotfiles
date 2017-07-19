
# hacks to run before everything else

# greatwhite.ics.cs.cmu.edu is far too old for anything I'd want to do
[[ $(hostname) =~ greatwhite ]] && exit

# ensure that these directories are available to us
export PATH=".:$HOME/bin:/usr/local/bin:$PATH"

# set XDG Base Directories appropriately
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Set global Solarized dark/light toggle
export SOLARIZED="dark"

# Change my iTerm2 profile based on $SOLARIZED setting
if [ "$TERM" = "iTerm.app" ]; then
  echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
fi
