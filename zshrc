# =========================================================================== #
#                                                                             #
#  .zshrc                                                                     #
#  Adapted from Tom Shen's zshrc                                              #
#                                                                             #
#  Author:  Jake Zimmerman                                                    #
#  Email:   jake@zimmerman.io                                                 #
#                                                                             #
# =========================================================================== #


# Make sure we are running interactively, else stop
[ -z "$PS1" ] && return
export PATH=".:$HOME/bin:/usr/local/bin:$PATH"

# Load oh-my-zsh
export ZSH="$HOME/.oh-my-zsh/"
export CASE_SENSITIVE="true"
plugins=(git brew)
#source $ZSH/oh-my-zsh.sh

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

# ----- miscellaneous  -------------------------------------------------------
setopt autocd completealiases extendedglob nomatch no_case_glob histappend

# Turn on vi keybindings <3 <3 <3 :D and other things
bindkey -v
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line

setopt -Y

export MENU_COMPLETE=1
export EDITOR="vim"

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

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
alias reload="source ~/.zshrc"
alias pyserv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias ip="curl curlmyip.com"
alias purgeswp="find . -regex \'.*.swp$\' -exec rm {}"
alias purgedrive='find ~/GoogleDrive/ -name Icon -exec rm -f {} \; -print'
alias purgeicon='find . -name Icon -exec rm -f {} \; -print'
which ack &> /dev/null && alias TODO="ack TODO"
which ghci &> /dev/null && alias has="ghci"
which grc &> /dev/null && alias grc="grc -es"

# Git aliases
alias git-lastmerge="git whatchanged -2 --oneline -p"
alias git-last="git whatchanged -1 --oneline -p"

alias ga="git add"
alias gap="git add --patch"

alias gc="git commit"
alias gca="git commit -a"
alias gcm="git commit -m"
alias gcam="git commit -am"

alias gs="git status"
alias gd="git diff"
alias gdw="git diff --color-words"

alias gl="git log --pretty=oneline --graph --decorate --abbrev-commit"
alias gll="git log --pretty=oneline --graph --decorate --abbrev-commit --all"

# ----- per machine setup ----------------------------------------------------
case `hostname` in
  *Jacobs-MacBook-Air*)
    # GNU coreutils with their actual names
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

    # aliases
    alias resethostname='sudo scutil --set HostName Jacobs-MacBook-Air'
    alias kinitandrew="kinit jezimmer@ANDREW.CMU.EDU"
    alias vim="/usr/local/bin/vim"
    alias sml="rlwrap sml"
    which coffee &> /dev/null && alias coffe="coffee"

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
    source /usr/local/bin/virtualenvwrapper.sh 2> /dev/null

    ;;
  *andrew*|*gates*|*shark*)
    # Source files that make working on these servers easier
    #source ~/.bashrc_gpi;
    export PATH="/afs/club/contrib/bin:$PATH";
    export MANPATH="$MANPATH:/afs/club.cc.cmu.edu/contrib/man"
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/afs/club.cc.cmu.edu/contrib/lib"
    alias sml="rlwrap sml"
    alias vim="~odb/bin/vim"
    aklog cs.cmu.edu
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

case `uname` in
  Darwin)
    # Non standard aliases
    which ggrep &> /dev/null && alias grep="ggrep --color=auto";
    which gls &> /dev/null && alias ls="gls -p --color";
    which gdircolors &> /dev/null && alias dircolors="gdircolors";
    which gdate &> /dev/null && alias date="gdate";
    which gsort &> /dev/null && alias duls="du -h -d1 | gsort -hr"

    if [ -e $(brew --prefix)/etc/zsh_completion ]; then
      source $(brew --prefix)/etc/zsh_completion
    fi
    ;;
  Linux)
    which tree &> /dev/null && alias tree="tree -C"
    ;;
esac

# ----- appearance -----------------------------------------------------------
# Load LS_COLORS
eval `dircolors ~/.dir_colors`
# Turn on italics
tic ~/.xterm-256color-italic.terminfo
export TERM=xterm-256color-italic

# ----- function -------------------------------------------------------------
update() {
  touch $HOME/.last_update

  # Updates for all hosts
  cd ~/.dotfiles/
  echo "$cblueb==>$cwhiteb Updating dotfiles...$cnone"
  git fetch --quiet origin
  if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/master)" ]; then echo "$credb  --> outdated.$cnone"; fi


  echo "$cblueb==>$cwhiteb Checking for outdated dotfiles submodules...$cnone"
  git submodule foreach --quiet 'git fetch --quiet && if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/master)" ]; then echo $path; fi'
  cd - &> /dev/null

  # Mac updates
  case `hostname` in
    *Jacobs-MacBook-Air*)
      echo "$cblueb==>$cwhiteb Renewing Kerberos ticket...$cnone"
      kinitandrew

      echo "$cblueb==>$cwhiteb Updating Homebrew...$cnone"
      brew update

      echo "$cblueb==>$cwhiteb Checking Homebrew...$cnone"
      brew doctor

      echo "$cblueb==>$cwhiteb Checking for outdated brew packages...$cnone"
      brew outdated --verbose
      ;;
    *andrew*|*gates*|*shark*)
      ;;
    metagross)
      echo "$cblueb==>$cwhiteb Updating package lists...$cnone"
      sudo apt-get update

      echo "$cblueb==>$cwhiteb Checking for outdated packages...$cnone"
      # modified from http://unix.stackexchange.com/questions/19470/list-available-updates-but-do-not-install-them#comment111161_75791
      apt-get -s upgrade| awk -F'[][() ]+' "/^Inst/{printf \"${cwhiteb}Prog${cnone}: %s\t${credb}cur${cnone}: %s\t${cgreen}avail${cnone}: %s\n\", \$2,\$3,\$4}"
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
    -c ":Man $*" \
    -c ":only" \
    -c ":set nu" \
    -c ":set nomodifiable" \
    -c ":map q :q<CR>"
}

# Open diffs in vim
vdiff() {
  diff $@ | vim -
}

init_django_completion() {
  if [ -n "$VIRTUAL_ENV" ]; then
    if [ -n "`grep \"django_bash_completion\" ${VIRTUAL_ENV}/bin/postactivate`" ]; then
      echo "${cgreen}Oh look!${cnone} You've already run this script for this virtual env."
    else
      echo 'source ~/bin/django_bash_completion' >> ${VIRTUAL_ENV}/bin/postactivate
      echo "${cgreen}Congrats!${cnone} You will have to re-run ${cblueb}\`workon <virtualenv>\`${cnone} for changes to apply."
    fi
  else
    echo "${cred}Whoops!${cnone} Looks like you're not in a virtual env."
    return 1
  fi
}

get_cs_afs_access() {
    # Script to give a user with an andrew.cmu.edu account access to cs.cmu.edu
    # See https://www.cs.cmu.edu/~help/afs/cross_realm.html for information.

    # Get tokens. This might create the user, but I'm not sure that that's
    # reliable, so we'll also try to do pts createuser.
    aklog cs.cmu.edu

    CUR_USER=`whoami`

    pts createuser $CUR_USER@ANDREW.CMU.EDU -cell cs.cmu.edu 2>&1 | grep -v "Entry for name already exists"

    aklog cs.cmu.edu

    echo "(aklog cs.cmu.edu &)" >> ~/.bashrc
}

vi-search-fix() {
  zle vi-cmd-mode
  zle .vi-history-search-backward
}

# ----- zsh stuff -------------------------------------------------------------
zstyle :compinstall filename $HOME/.zshrc

## case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*:*:*:*:*' menu ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={a-zA-Z}' #'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' verbose false

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit

# Fix ESC + /
autoload vi-search-fix
zle -N vi-search-fix
bindkey -M viins '\e/' vi-search-fix

source $HOME/.zfunctions/syntax-highlighting/zsh-syntax-highlighting.zsh

# To color each machine's prompt differently
case `hostname` in
  #*MacBook*)
  #  PROMPT_PURE_DIR_COLOR="%F{093}"
  #  ;;
  #*andrew*|*gates*|*shark*)
  #  PROMPT_PURE_DIR_COLOR="%F{076}"
  #  ;;
  #alarmpi)
  #  PROMPT_PURE_DIR_COLOR="%F{027}"
  #  ;;
  #jake-raspi)
  #  PROMPT_PURE_DIR_COLOR="%F{164}"
  #  ;;
  #*xubuntu*)
  #  PROMPT_PURE_DIR_COLOR="%F{057}"
  #  ;;
  #pop.scottylabs.org)
  #  PROMPT_PURE_DIR_COLOR="%F{227}"
  #  ;;
  #scottylabs)
  #  PROMPT_PURE_DIR_COLOR="%F{202}"
  #  ;;
  #metagross)
  #  PROMPT_PURE_DIR_COLOR="%F{027}"
  #  ;;
  #*)
  #  PROMPT_PURE_DIR_COLOR="%F{196}"
  #  ;;
  *MacBook*)
    PROMPT_PURE_DIR_COLOR="$cmagentab"
    ;;
  *andrew*|*gates*|*shark*)
    mesg n
    PROMPT_PURE_DIR_COLOR="%F{green}"
    ;;
  alarmpi)
    PROMPT_PURE_DIR_COLOR="%F{blue}"
    ;;
  jake-raspi)
    PROMPT_PURE_DIR_COLOR="%F{magenta}"
    ;;
  *xubuntu*)
    PROMPT_PURE_DIR_COLOR="%F{cyan}"
    ;;
  pop.scottylabs.org)
    PROMPT_PURE_DIR_COLOR="%F{yellow}"
    ;;
  scottylabs)
    PROMPT_PURE_DIR_COLOR="$credb"
    ;;
  metagross)
    PROMPT_PURE_DIR_COLOR="%F{blue}"
    ;;
  *)
    PROMPT_PURE_DIR_COLOR="%F{red}"
    ;;
esac

#PROMPT_PURE_VCS_COLOR="%F{cyan}"
#PROMPT_PURE_EXEC_TIME_COLOR="%F{blue}"
PROMPT_PURE_SUCCESS_COLOR="%F{cyan}"
#PROMPT_PURE_FAILURE_COLOR="%F{yellow}"

PURE_NO_SSH_USERNAME=1

PURE_GIT_PULL=0
prompt pure

#source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
