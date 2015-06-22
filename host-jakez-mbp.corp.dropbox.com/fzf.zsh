# Setup fzf
# ---------
if [[ ! "$PATH" =~ "/usr/local/Cellar/fzf/0.10.0/bin" ]]; then
  export PATH="$PATH:/usr/local/Cellar/fzf/0.10.0/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" =~ "/usr/local/Cellar/fzf/0.10.0/man" && -d "/usr/local/Cellar/fzf/0.10.0/man" ]]; then
  export MANPATH="$MANPATH:/usr/local/Cellar/fzf/0.10.0/man"
fi

# Auto-completion
# ---------------
[[ $- =~ i ]] && source "/usr/local/Cellar/fzf/0.10.0/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/Cellar/fzf/0.10.0/shell/key-bindings.zsh"

