###############################################################################
##    .bash_profile                                                          ##
##    @author Jake Zimmerman                                                 ##
##    @email jake@zimmerman.io                                               ##
###############################################################################

## NOTE: 
## This .bash_profile requires brew and coreutils if you are running on OS X.

# Make sure we are running interactively, else stop
# (I once had a really annoying problem with scp when this line wasn't here)
[ -z "$PS1" ] && return

echo -n 'Loading...'

case $HOSTNAME in
  *andrew*|*gates*) source ~/.bashrc_gpi
                    export PATH="$PATH:/afs/club/contrib/bin";&
  *scottylabs*)     export PATH="$PATH:$HOME/bin" ;;
esac

# ----- aliases --------------------------------------------------------------
if [ `uname` = "Darwin" ]
then
  alias ls="gls -p --color"
  alias dircolors="gdircolors"
  alias duls="du -h -d1 | gsort -hr"
  alias kinitandrew="kinit jezimmer@ANDREW.CMU.EDU"
  alias vim="/usr/local/bin/vim"
else
  alias ls="ls -p --color=auto"
  alias duls="du -h -d1 | sort -hr"
fi
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias cdd="cd .."
alias sml="rlwrap sml"

alias pyserv="python -m SimpleHTTPServer"
alias purgeswp='rm -i `find . | grep .swp$`'

# ------ git stuff -----
#   git-log:       show a pretty list of commit hashes and messages
#   git-lastmerge: show what changed on the last merge of the repo
#   git-last:      show what changed on the last commit
alias git-log="git log --pretty=oneline --graph --decorate"
alias git-lastmerge="git whatchanged -2 --oneline -p"
alias git-last="git whatchanged -1 --oneline -p"
# -----------------------------------------------------------------------------

echo -n '.'

# Turn on italics
tic ~/.xterm-256color-italic.terminfo
export TERM=xterm-256color-italic
echo -n '.'

# Mac tools
if [ `uname` = "Darwin" ]; then
  ### Added by the Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"

#  # ruby...
#  # Add RVM to PATH for scripting
#  PATH=$PATH:$HOME/.rvm/bin 
#  # Load RVM into a shell session *as a function*
#  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
#  echo -n '.'
fi

# Load utility colors, change ls colors
source ~/.COLORS
eval `dircolors ~/.dir_colors`
echo -n '.'

color_my_prompt() {
  # To color each machine's prompt differently
  local __git_branch_color="\[$(color256 227)\]"

  case $HOSTNAME in
    *MacBook*)
      local __user_color=093;
      local __loc_color=141
      ;;
    *andrew*|*gates*)
      local __user_color=076;
      local __loc_color=078;
      ;;
    alarmpi)
      local __user_color=027;
      local __loc_color=045;
      ;;
    *xubuntu*)
      local __user_color=057;
      local __loc_color=055;
      ;;
    pop.scottylabs.org)
      local __user_color=227;
      local __loc_color=222;
      local __git_branch_color="\[$(color256 141)\]"
      ;;
    scottylabs)
      local __user_color=202;
      local __loc_color=214;
      ;;
    *)
      local __user_color=196;
      local __loc_color=015;
      ;;
  esac

  if test -z "$VIRTUAL_ENV" ; then
      __python_virtualenv=""
  else
    __python_virtualenv="\[$(color256 141)\][`basename \"$VIRTUAL_ENV\"`]\[${cnone}\] "
  fi
  local __user_and_host="\[$(color256 $__user_color)\]\u@\[${cgray}\]\h"
  local __cur_location="\[${swhite}\]:\[$(color256 $__loc_color)\]\w"
  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
  local __cur_time="\[$(color256 247)\][\@]\[${cnone}\]"
  if [ $(id -u) -eq 0 ]
  then local __prompt_tail="\[${cred}\]#"
  else local __prompt_tail="\[${ccyanb}\]$"
  fi
  local __last_color="\[${cnone}\]\[$(color256 039)\]"
  export PS1="\[${cnone}\]${__python_virtualenv}├── $__user_and_host$__cur_location\[${cnone}\] ──┤ $__cur_time $__git_branch_color$__git_branch\[${cnone}\]\n$__prompt_tail$__last_color "
}
color_my_prompt
echo -n '.'

# Turn the color back to normal (light gray/white) after the command executes
trap 'echo -ne "\033[0m"' DEBUG

# Turn on vi keybindings <3 <3 <3 :D and other things
set -o vi
shopt -s autocd
echo -n '.'

if [ `uname` == "Darwin" ]; then
  # Settings for virtualenv and virtualenvwrapper (for python virtual environments)
  export WORKON_HOME=$HOME/.virtualenvs
  source /usr/local/bin/virtualenvwrapper.sh
  export PATH=.:/Users/Jake/bin:/usr/local/bin:$PATH
  echo -n '.'

  if [ -e $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
  echo -n '.'
fi

# Get coloring in man pages
# man() {
#     env LESS_TERMCAP_mb=$'\E[01;31m' \
#     LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#     LESS_TERMCAP_me=$'\E[0m' \
#     LESS_TERMCAP_se=$'\E[0m' \
#     LESS_TERMCAP_so=$'\E[38;5;246m' \
#     LESS_TERMCAP_ue=$'\E[0m' \
#     LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#     man "$@"
# }

echo -en '.\r'
