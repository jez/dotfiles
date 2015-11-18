
# Turn on vi keybindings <3 <3 <3 :D and other things
set -o vi

# if command not found, but directory exists, cd into it
shopt -s autocd

# bash completion (bash installed through Homebrew)
if [ -e $(which brew &> /dev/null && brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

# pip bash completion
which pip &> /dev/null && eval `pip completion --bash`
