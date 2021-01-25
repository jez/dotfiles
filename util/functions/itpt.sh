#!/usr/bin/env bash
# Toggle the current color scheme between Solarized Light and Solarized Dark
# Mnemonic: iTerm2 Profile Toggle

itpt() {
  if [ "$SOLARIZED" = "dark" ]; then
    sed -i.bak 's/"dark"/"light"/' ~/.util/before.sh
    rm ~/.util/before.sh.bak > /dev/null

    export SOLARIZED="light"
  elif [ "$SOLARIZED" = "light" ]; then
    sed -i.bak 's/"light"/"dark"/' ~/.util/before.sh
    rm ~/.util/before.sh.bak > /dev/null

    export SOLARIZED="dark"
  fi

  # Change my iTerm2 profile based on $SOLARIZED setting
  if [ "$TERM_PROGRAM" = "iTerm.app" ] || [ "$LC_TERMINAL" = "iTerm2" ]; then
    echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
  elif [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    true
  else # alacritty
    local __config="$HOME/.config/alacritty/alacritty.yml"
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

  local __dircolors="$HOME/.dircolors"
  if [ "$SOLARIZED" = "dark" ]; then
    sed -E -i.bak 's/00;30 (## solarized-light ##)/00;37 ## solarized-dark ##/' "$__dircolors"
    sed -E -i.bak 's/01;36 (## solarized-light ##)/01;32 ## solarized-dark ##/' "$__dircolors"
    rm "$__dircolors.bak" > /dev/null
  elif [ "$SOLARIZED" = "light" ]; then
    sed -E -i.bak 's/00;37 (## solarized-dark ##)/00;30 ## solarized-light ##/' "$__dircolors"
    sed -E -i.bak 's/01;32 (## solarized-dark ##)/01;36 ## solarized-light ##/' "$__dircolors"
    rm "$__dircolors.bak" > /dev/null
  fi
  command -v dircolors &> /dev/null && eval "$(dircolors ~/.dircolors)"

  if [ "$FZF_DEFAULT_OPTS_DARK" != "" ] || [ "$FZF_DEFAULT_OPTS_LIGHT" != "" ]; then
    # shellcheck disable=SC1090
    source "$HOME/.util/fzf.zsh"
  fi

  export BAT_THEME="Solarized ($SOLARIZED)"

  echo "Profile toggled. Open new tab for full effect."
}
