# Setup fzf
# ---------
if [[ ! "$PATH" =~ "/usr/local/Cellar/fzf/0.9.11/bin" ]]; then
  export PATH="$PATH:/usr/local/Cellar/fzf/0.9.11/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "/usr/local/Cellar/fzf/0.9.11/man" && -d "/usr/local/Cellar/fzf/0.9.11/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/Cellar/fzf/0.9.11/man"
fi

# Auto-completion
# ---------------
# [[ $- =~ i ]] && source "/usr/local/Cellar/fzf/0.9.11/shell/completion.zsh"

# Key bindings
# ------------
source "/usr/local/Cellar/fzf/0.9.11/shell/key-bindings.zsh"

