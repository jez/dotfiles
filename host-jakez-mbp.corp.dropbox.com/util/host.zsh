
# fzf fuzzy file finding
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export FZF_CTRL_T_COMMAND='ag -l -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Modify keydings to match ctrlp.vim
bindkey '^P' fzf-file-widget
bindkey '^N' fzf-cd-widget
bindkey -M vicmd '/' fzf-history-widget
bindkey '^[/' fzf-history-widget

