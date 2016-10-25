# Toggle the current color scheme between Solarized Light and Solarized Dark
# Mnemonic: iTerm2 Profile Toggle

itpt() {
  if [ "$SOLARIZED" = "dark" ]; then
    sed -i.bak 's/"dark"/"light"/' ~/.dotfiles/util/before.sh
    rm ~/.dotfiles/util/before.sh.bak > /dev/null
  elif [ "$SOLARIZED" = "light" ]; then
    sed -i.bak 's/"light"/"dark"/' ~/.dotfiles/util/before.sh
    rm ~/.dotfiles/util/before.sh.bak > /dev/null
  fi

  echo "Profile toggled. Open a new tab to pick up these changes."
}
