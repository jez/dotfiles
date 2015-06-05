
# fzf fuzzy file finding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Modify keydings to match ctrlp.vim
bindkey '^P' fzf-file-widget
bindkey '^N' fzf-cd-widget
bindkey -M vicmd '/' fzf-history-widget
bindkey '^[/' fzf-history-widget

