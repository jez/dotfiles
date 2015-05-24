# Setup fzf
# ---------
if [[ ! "$PATH" =~ "/usr/local/Cellar/fzf/0.9.12/bin" ]]; then
  export PATH="$PATH:/usr/local/Cellar/fzf/0.9.12/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "/usr/local/Cellar/fzf/0.9.12/man" && -d "/usr/local/Cellar/fzf/0.9.12/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/Cellar/fzf/0.9.12/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "/usr/local/Cellar/fzf/0.9.12/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/Cellar/fzf/0.9.12/shell/key-bindings.zsh"

