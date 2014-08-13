# =========================================================================== #
#                                                                             #
#  .bash_profile                                                              #
#                                                                             #
#  Author:  Jake Zimmerman                                                    #
#  Email:   jake@zimmerman.io                                                 #
#                                                                             #
# =========================================================================== #

# Make sure we are running interactively, else stop
[ -z "$PS1" ] && return
export PATH=".:$HOME/bin:/usr/local/bin:$PATH"
# Load utility colors
source ~/.COLORS

# ----- daily updates --------------------------------------------------------
[ ! -e $HOME/.last_update ] && touch $HOME/.last_update
# Initialize for when we have no GNU date available
last_check=0
time_now=0

# Unix last command to check the log of logins, grab the most recent
last_check_string=`ls -l $HOME/.last_update | awk '{print $6" "$7" "$8}'`

# Darwin uses BSD, check for gdate, else use date
if [[ `uname` = "Darwin" && -n `which gdate` ]]; then
  last_login=`gdate -d"$last_check_string" +%s`
  time_now=`gdate +%s`
else
  # Ensure this is GNU grep
  if [ -n "`date --version 2> /dev/null | grep GNU`" ]; then
    last_login=`date -d"$last_check_string" +%s`
    time_now=`date +%s`
  fi
fi

time_since_check=$((time_now - last_login))

if [ "$time_since_check" -ge 86400 ]; then
  echo "$cred==>$cwhiteb Your system is out of date!$cnone"
  echo 'Run `update` to bring it up to date.'
fi

# ============================================================================
# ============================================================================
# ===== START OF CONFIGURATION ===============================================
# ============================================================================
# ============================================================================

# Keep track of how long loading takes
echo -n 'Loading...'

# ----- miscellaneous  -------------------------------------------------------
# Turn on vi keybindings <3 <3 <3 :D and other things
set -o vi
export EDITOR="vim"

# if command not found, but directory exists, cd into it
shopt -s autocd

echo -n '.'

# ----- aliases --------------------------------------------------------------
# General aliases
alias grep="grep --color=auto"
alias ls="ls -p --color=auto"
alias duls="du -h -d1 | sort -hr"
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"
alias cdd="cd .."
alias resolve='cd "`pwd -P`"'
alias reload="source ~/.bash_profile"
alias pyserv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias ip="curl curlmyip.com"
alias purgeswp='rm -i `find . | grep .swp$`'
alias purgedrive='find ~/Google\ Drive/ -name Icon -exec rm -f {} \; -print'
which ack > /dev/null && alias TODO="ack TODO"
which ghci > /dev/null && alias has="ghci"
which grc > /dev/null && alias grc="grc -es"

# Git aliases
alias git-log="git log --pretty=oneline --graph --decorate --abbrev-commit"
alias git-lastmerge="git whatchanged -2 --oneline -p"
alias git-last="git whatchanged -1 --oneline -p"
alias gap="git add --patch"
alias gc="git commit"
alias gca="git commit -a"
alias gcam="git commit -am"
alias gs="git status"
echo -n '.'

# ----- per machine setup ----------------------------------------------------
case $HOSTNAME in
  *Jacobs-MacBook-Air*)
    # aliases 
    alias kinitandrew="kinit jezimmer@ANDREW.CMU.EDU"
    alias vim="/usr/local/bin/vim"
    alias sml="rlwrap sml"

    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    # ruby...
    # To use Homebrew's directories rather than ~/.rbenv
    export RBENV_ROOT="/usr/local/var/rbenv"
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    alias bex="bundle exec"
    
    # Settings for virtualenv and virtualenvwrapper 
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    echo -n '.'

    ;;
  *andrew*|*gates*) 
    # Source files that make working on these servers easier
    source ~/.bashrc_gpi;
    export PATH="$PATH:/afs/club/contrib/bin";
    echo -n '.'
    ;;
  alarmpi)
    ;;
  jake-raspi)
    ;;
  *xubuntu*)
    ;;
  pop.scottylabs.org)
    ;;
  scottylabs)
    ;;
  metagross)
    export PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"
    alias ack="ack-grep"
    ;;
  *)
    ;;
esac
echo -n '.'

case `uname` in
  Darwin)
    # Non standard aliases
    which gls > /dev/null && alias ls="gls -p --color";
    which gdircolors > /dev/null && alias dircolors="gdircolors";
    which gdate > /dev/null && alias date="gdate";
    which gsort > /dev/null && alias duls="du -h -d1 | gsort -hr"
    echo -n '.'

    if [ -e $(brew --prefix)/etc/bash_completion ]; then
      source $(brew --prefix)/etc/bash_completion
      echo -n '.'
    fi
    ;;
  Linux)
    ;;
esac
echo -n '.'

# ----- appearance -----------------------------------------------------------
# Load LS_COLORS
eval `dircolors ~/.dir_colors`
# Turn on italics
tic ~/.xterm-256color-italic.terminfo
export TERM=xterm-256color-italic

echo -n '.'

# ----- function -------------------------------------------------------------
update() {
  touch $HOME/.last_update

  # Mac updates
  case $HOSTNAME in
    *Jacobs-MacBook-Air*)
      echo "$cblueb==>$cwhiteb Updating Homebrew...$cnone"
      brew update

      echo "$cblueb==>$cwhiteb Checking Homebrew...$cnone"
      brew doctor

      echo "$cblueb==>$cwhiteb Checking for outdated brew packages...$cnone"
      brew outdated --verbose

      echo "$cblueb==>$cwhiteb Checking for outdated ruby gems...$cnone"
      gem outdated

      echo "$cblueb==>$cwhiteb Checking for outdated node packages...$cnone"
      npm outdated

      echo "$cblueb==>$cwhiteb Checking for outdated python packages...$cnone"
      pip list -o

      echo "$cblueb==>$cwhiteb Checking for outdated pathogen plugins...$cnone"
      cd ~/.dotfiles/
      git submodule foreach git fetch
      cd -
      ;;
  esac
}

## Open Matching
# grep for non-binary files matching a pattern and open them in vim tabs
# will automatically search for the specified regexp
om() {
  local pattern="$@"
  local result="`grep -l -r --binary-files=without-match "$pattern" * | tr '\n' ' '`"
  if [ -n "$result" ]; then
    vim -p -c "/$pattern" $result
  else
    echo "${cwhiteb}No files matching the pattern: $sred$pattern$cnone"
  fi
}

# Get coloring in man pages
man() {
  env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# Open man pages in vim
vman() {
  vim -R \
    -c ':source $VIMRUNTIME/ftplugin/man.vim' \
    -c ":Man $1" \
    -c ":only" \
    -c ":set nu" \
    -c ":set nomodifiable" \
    -c ":map q :q<CR>"
}

# Open diffs in vim
vdiff() {
  diff $@ | vim -
}

# ----- set the PS1 variable -------------------------------------------------
color_my_prompt() {
  # To color each machine's prompt differently
  case $HOSTNAME in
    *MacBook*)
      local __user_color=093;
      local __loc_color=141;
      local __host="MacBook";
      ;;
    *andrew*|*gates*)
      local __user_color=076;
      local __loc_color=078;
      local __host="\h"
      ;;
    alarmpi)
      local __user_color=027;
      local __loc_color=045;
      local __host="\h"
      ;;
    jake-raspi)
      local __user_color=164;
      local __loc_color=170;
      local __host="\h"
      ;;
    *xubuntu*)
      local __user_color=057;
      local __loc_color=055;
      local __host="xubuntu"
      ;;
    pop.scottylabs.org)
      local __user_color=227;
      local __loc_color=222;
      local __host="sl-prod"
      ;;
    scottylabs)
      local __user_color=202;
      local __loc_color=214;
      local __host="sl-dev"
      ;;
    metagross)
      local __user_color=027;
      local __loc_color=244;
      local __host="\h"
      ;;
    *)
      local __user_color=196;
      local __loc_color=015;
      local __host="\h"
      ;;
  esac

  __python_virtualenv=""
  if [ -n "$VIRTUAL_ENV" ]; then
    __python_virtualenv="\[$(color256 141)\][`basename \"$VIRTUAL_ENV\"`]\[${cnone}\] "
  fi

  local __user_and_host="\[$(color256 $__user_color)\]\u\[${cgray}\]@$__host"
  local __cur_location="\[${swhite}\]:\[$(color256 $__loc_color)\]\w"

  # change the color of the git branch depending on whether the repo is "messy" or "clean"
  local __git_branch_color='`if git diff --quiet --ignore-submodules HEAD 2> /dev/null; then echo \[${cgreen}\]; else echo \[${cyellow}\]; fi`'

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

# Turn the color back to normal after the command executes
trap 'echo -ne "\033[0m"' DEBUG
echo -en '.\r'
