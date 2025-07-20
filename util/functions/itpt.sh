#!/usr/bin/env bash
# Toggle the current color scheme between Solarized Light and Solarized Dark
# Mnemonic: iTerm2 Profile Toggle

script_path="$(realpath "$0")"
dotfiles_dir=${script_path%/util/functions/itpt.sh}

itpt() {
  if [ "$SOLARIZED" = "dark" ]; then
    sed -i.bak 's/"dark"/"light"/' "$dotfiles_dir/util/before.sh"
    rm "$dotfiles_dir/util/before.sh.bak" > /dev/null

    export SOLARIZED="light"
  elif [ "$SOLARIZED" = "light" ]; then
    sed -i.bak 's/"light"/"dark"/' "$dotfiles_dir/util/before.sh"
    rm "$dotfiles_dir/util/before.sh.bak" > /dev/null

    export SOLARIZED="dark"
  fi

  # Change my iTerm2 profile based on $SOLARIZED setting
  if [ "$TERM_PROGRAM" = "iTerm.app" ] || [ "$LC_TERMINAL" = "iTerm2" ]; then
    echo -e "\033]50;SetProfile=solarized-$SOLARIZED\a"
  elif [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    true
  fi

  if command -v osascript &> /dev/null; then
    macos_dark_mode=false
    if [ "$SOLARIZED" = "dark" ]; then
      macos_dark_mode="true"
    fi
    osascript -e "tell app \"System Events\" to tell appearance preferences to set dark mode to $macos_dark_mode"
  fi

  if ! command -v realpath &> /dev/null; then
    echo "Install 'realpath' to toggle the Alacritty profile"
  else
    local __config
    __config="$(realpath "$HOME/.config/alacritty/alacritty.toml")"
    if [ "$SOLARIZED" = "dark" ]; then
      sed -E -i.bak 's/# ([^#].*)(## solarized-dark ##)/\1\2/' "$__config"
      sed -E -i.bak 's/([^#].*)(## solarized-light ##)/# \1\2/' "$__config"
      rm "$__config.bak" > /dev/null
    elif [ "$SOLARIZED" = "light" ]; then
      sed -E -i.bak 's/([^#].*)(## solarized-dark ##)/# \1\2/' "$__config"
      sed -E -i.bak 's/# ([^#].*)(## solarized-light ##)/\1\2/' "$__config"
      rm "$__config.bak" > /dev/null
    fi
  fi


  if [ -n "$TMUX" ]; then
    tmux source "$XDG_CONFIG_HOME/tmux/solarized-$SOLARIZED.tmuxline"
  fi

  local __dircolors="$dotfiles_dir/dircolors"
  if [ "$SOLARIZED" = "dark" ]; then
    sed -E -i.bak 's/00;30 (## solarized-light ##)/00;37 ## solarized-dark ##/' "$__dircolors"
    sed -E -i.bak 's/01;36 (## solarized-light ##)/01;32 ## solarized-dark ##/' "$__dircolors"
    rm "$__dircolors.bak" > /dev/null
  elif [ "$SOLARIZED" = "light" ]; then
    sed -E -i.bak 's/00;37 (## solarized-dark ##)/00;30 ## solarized-light ##/' "$__dircolors"
    sed -E -i.bak 's/01;32 (## solarized-dark ##)/01;36 ## solarized-light ##/' "$__dircolors"
    rm "$__dircolors.bak" > /dev/null
  fi
  command -v dircolors &> /dev/null && eval "$(dircolors "$dotfiles_dir/dircolors")"

  if [ "$FZF_DEFAULT_OPTS_DARK" != "" ] || [ "$FZF_DEFAULT_OPTS_LIGHT" != "" ]; then
    # shellcheck disable=SC1091
    source "$dotfiles_dir/util/fzf.zsh"
  fi

  export BAT_THEME="Solarized ($SOLARIZED)"

  if command -v dconf &> /dev/null && grep -q "DISTRIB_ID=Pop" /etc/lsb-release; then
    case "$SOLARIZED" in
      dark)
        dconf write /org/gnome/desktop/interface/gtk-theme "'Pop-dark'"
        ;;
      light)
        dconf write /org/gnome/desktop/interface/gtk-theme "'Pop'"
        ;;
    esac
  fi

  echo "Profile toggled. Open new tab for full effect."
}
