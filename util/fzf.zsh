#
# fzf.zsh - fzf-specific configurations
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#   Toggle appropriate comments to switch colorscheme
#   from Solarized Light to Dark
#
# Notes
#   These configurations are for fzf, which is an amazing program. I can't do
#   it justice with words. You should go here[1] and watch the gif to have your
#   mind blown.
#
#   [1]: https://github.com/junegunn/fzf
#

# Configure fzf to ignore files that aren't tracked by Git
export FZF_DEFAULT_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore' --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="fd --type f --hidden --ignore-file '$HOME/.gitignore' --strip-cwd-prefix"
export FZF_ALT_C_COMMAND="fd --type d --hidden --ignore-file '$HOME/.gitignore' --strip-cwd-prefix"

# This is one of many color schemes for fzf. Check the fzf wiki for more
_gen_fzf_default_opts() {
  local base03="234"
  local base02="235"
  local base01="240"
  local base00="241"
  local base0="244"
  local base1="245"
  local base2="254"
  local base3="230"
  local yellow="136"
  local orange="166"
  local red="160"
  local magenta="125"
  local violet="61"
  local blue="33"
  local cyan="37"
  local green="64"

  # fzf uses ncurses for it's UI. ncurses doesn't support 24-bit color, and
  # last time I tried, I couldn't get the ANSI 16 colors to play nicely.

  # Solarized Dark color scheme for fzf
  export FZF_DEFAULT_OPTS_DARK="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base2,bg+:-1,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base3,marker:$base3,spinner:$yellow
    --no-separator
  "
  # Solarized Light color scheme for fzf
  export FZF_DEFAULT_OPTS_LIGHT="
    --color fg:-1,bg:-1,hl:$blue,fg+:$base02,bg+:-1,hl+:$blue
    --color info:$yellow,prompt:$yellow,pointer:$base03,marker:$base03,spinner:$yellow
  "

  FZF_DEFAULT_OPTS="--no-separator --bind scroll-up:offset-up+offset-up+offset-up,scroll-down:offset-down+offset-down+offset-down"
  if [ "$SOLARIZED" = "dark" ]; then
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS_DARK"
  elif [ "$SOLARIZED" = "light" ]; then
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS_LIGHT"
  else
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $FZF_DEFAULT_OPTS_DARK"
  fi
  export FZF_DEFAULT_OPTS
}
_gen_fzf_default_opts

source <(fzf --zsh)

# Modify fzf keydings to match ctrlp.vim
bindkey '^P' fzf-file-widget
bindkey '^N' fzf-cd-widget
# Use zsh Normal Mode + / (reverse-i-search) to use fzf instead
bindkey -M vicmd '/' fzf-history-widget
bindkey '^[/' fzf-history-widget

# From https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

# Will return non-zero status if the current directory is not managed by git
is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# Select file from git status
gfi() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf --height 40% --reverse -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}

# Select commit from git history
# gh() {
#   is_in_git_repo || return
#   git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
#   fzf --height 50% --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
#     --header 'Press CTRL-S to toggle sort' \
#     --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES |
#   grep -o "[a-f0-9]\{7,\}"
# }

# A helper function to join multi-line output from fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

fzf-gfi-widget() { local result=$(gfi | join-lines); zle reset-prompt; LBUFFER+=$result }
# fzf-gh-widget()  { local result=$(gh  | join-lines); zle reset-prompt; LBUFFER+=$result }
zle -N fzf-gfi-widget
# zle -N fzf-gh-widget
bindkey '^gf' fzf-gfi-widget
# bindkey '^gh' fzf-gh-widget
