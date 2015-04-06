# Setup fzf
# ---------
if [[ ! "$PATH" =~ "/usr/local/Cellar/fzf/0.9.7/bin" ]]; then
  export PATH="$PATH:/usr/local/Cellar/fzf/0.9.7/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "/usr/local/Cellar/fzf/0.9.7/man" && -d "/usr/local/Cellar/fzf/0.9.7/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/Cellar/fzf/0.9.7/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "/usr/local/Cellar/fzf/0.9.7/shell/completion.zsh"

# Key bindings
# ------------
source "/usr/local/Cellar/fzf/0.9.7/shell/key-bindings.zsh"

