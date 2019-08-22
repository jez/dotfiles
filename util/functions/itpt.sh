# Toggle the current color scheme between Solarized Light and Solarized Dark
# Mnemonic: iTerm2 Profile Toggle

itpt() {
  if [ "$SOLARIZED" = "dark" ]; then
    sed -i.bak 's/"dark"/"light"/' ~/.dotfiles/util/before.sh
    rm ~/.dotfiles/util/before.sh.bak > /dev/null

    export SOLARIZED="light"
  elif [ "$SOLARIZED" = "light" ]; then
    sed -i.bak 's/"light"/"dark"/' ~/.dotfiles/util/before.sh
    rm ~/.dotfiles/util/before.sh.bak > /dev/null

    export SOLARIZED="dark"
  fi

  # Change my iTerm2 profile based on $SOLARIZED setting
  if [ "$TERM_PROGRAM" = "iTerm.app" ]; then
    echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
  elif [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    true
  else # alacritty
    local __config="$HOME/.dotfiles/config/alacritty/alacritty.yml"
    if [ "$SOLARIZED" = "dark" ]; then
      sed -E -i.bak 's/# ([[:alpha:]].*)(## solarized-dark ##)/\1\2/' "$__config"
      sed -E -i.bak 's/([[:alpha:]].*)(## solarized-light ##)/# \1\2/' "$__config"
      rm "$__config.bak" > /dev/null
    elif [ "$SOLARIZED" = "light" ]; then
      sed -E -i.bak 's/([[:alpha:]].*)(## solarized-dark ##)/# \1\2/' "$__config"
      sed -E -i.bak 's/# ([[:alpha:]].*)(## solarized-light ##)/\1\2/' "$__config"
      rm "$__config.bak" > /dev/null
    fi
  fi

  if [ -n "$TMUX" ]; then
    tmux source "$XDG_CONFIG_HOME/tmux/solarized-$SOLARIZED.tmuxline"
  fi

  echo "Profile toggled. Open new tab for full effect."
}
