
# Open man pages in vim using the vim-superman plugin
#
#     https://github.com/jez/vim-superman
#

# zsh completion if in zsh
which compdef &> /dev/null && compdef vman="man"
vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}

