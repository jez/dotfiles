# Setup fzf
# ---------
if [[ ! "$PATH" == */home/vagrant/from-source/fzf/bin* ]]; then
  export PATH="$PATH:/home/vagrant/from-source/fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */home/vagrant/from-source/fzf/man* && -d "/home/vagrant/from-source/fzf/man" ]]; then
  export MANPATH="$MANPATH:/home/vagrant/from-source/fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/vagrant/from-source/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/vagrant/from-source/fzf/shell/key-bindings.zsh"

