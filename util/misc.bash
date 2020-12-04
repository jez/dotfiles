
# Turn on vi keybindings <3 <3 <3 :D and other things
set -o vi

# if command not found, but directory exists, cd into it
shopt -s autocd

# bash completion (bash installed through Homebrew)
if which brew &> /dev/null; then
  if [ -e $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

true
