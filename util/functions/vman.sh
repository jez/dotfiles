
# Open man pages in vim using the vim-superman plugin
#
#     https://github.com/jez/vim-superman
#

# zsh completion if in zsh
which compdef &> /dev/null && compdef vman="man"
vman() {
  # Check that manpage exists to prevent visual noise.
  if [ $# -eq 0 ]; then
    echo "What manual page do you want?";
    return 1
  elif ! man -w "$@" > /dev/null; then
    return 1
  fi

  ${EDITOR:-vim} -c 'autocmd! User GoyoLeave :qall' -c "SuperMan $*" -c "Goyo"
}

