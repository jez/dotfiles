
# Open man pages in vim using the vim-superman plugin
#
#     https://github.com/jez/vim-superman
#

# zsh completion if in zsh
which compdef &> /dev/null && compdef vman="man"
vman() {
  # Check that manpage exists to prevent visual noise.
  if ! man -d "$@" &> /dev/null; then
    echo "No manual entry for $*"
    exit 1
  fi

  vim -c "SuperMan $*"
}

