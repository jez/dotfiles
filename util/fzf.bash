#
# fzf.bash - fzf-specific configurations
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
    --no-separator
  "

  if [ "$SOLARIZED" = "dark" ]; then
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS_DARK"
  elif [ "$SOLARIZED" = "light" ]; then
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS_LIGHT"
  else
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS_DARK"
  fi
}
_gen_fzf_default_opts


source <(fzf --bash)

# Modify fzf keydings to match ctrlp.vim
bind -x '"\C-p": "fzf-file-widget"'
bind -x '"\C-n": "fzf-cd-widget"'
# Use zsh Normal Mode + / (reverse-i-search) to use fzf instead
bind -m vi-command '"/": "fzf-history-widget"'

