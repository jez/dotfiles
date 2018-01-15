
# ----- General ---------------------------------------------------------------

# colorize grep and ls
alias grep &> /dev/null || alias grep="grep --color=auto"
alias ls='ls -p --color=auto -w $(($COLUMNS<120?$COLUMNS:120))'
alias l="ls"

# 'r' in zsh is set up to repeat the last command (!!)
alias r="true"

# manipulate files verbosely (print log of what happened)
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

# so much easier to type than `cd ..`
alias cdd="cd .."
alias cddd="cd ../.."
alias cdddd="cd ../../.."
alias cddddd="cd ../../../.."
alias cdddddd="cd ../../../../.."
alias cddddddd="cd ../../../../../.."

# use popd to navigate directory stack (like "Back" in a browser)
alias b="popd"

# open multiple files in Vim tabs
alias vim &> /dev/null || alias vim="vim -p"

# open multiple files in Vim vertical splits
alias vimv="vim -O"

# open Vim directly to Goyo mode (distraction-free writing mode)
alias vimg="vim +Goyo"

alias bex="bundle exec"

# I'm pretty proud of these ones
alias :q="clear"
alias clera="clear"
alias lcera="clear"
alias lcear="clear"
alias :tabe="vim"
alias :Vs="vimv"
alias :vs="vimv"

# Redirect stderr and stdout when using GRC
which grc &> /dev/null && alias grc="grc -es"

# look up LaTeX documentation
which texdef &> /dev/null && alias latexdef="texdef --tex latex"

# Easily download an MP3 from youtube on the command line
which youtube-dl &> /dev/null && alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"

which doctoc &> /dev/null && alias doctoc='doctoc --title="## Table of Contents"'

# Pretend that tmux is XDG Base Directory conformant
which tmux &> /dev/null && alias tmux='tmux -f "$XDG_CONFIG_HOME"/tmux/tmux.conf'

# Use --no-bold for Solarized colors
alias icdiff="icdiff --no-bold"

# dump syntax highlighted file to screen
alias hicat='highlight -O truecolor --style=solarized-$SOLARIZED'

# Node module for lorem-ipsum
alias words="lorem-ipsum --units words --count"
alias paras="lorem-ipsum --units paragraphs --count"

# ----- aliases that are actually full-blown commands -------------------------

# list disk usage statistics for the current folder
alias duls="du -h -d1 | sort -hr"

# print my IP
alias ip="curl ifconfig.co"

# resolve a symlink in the PWD to a fully qualified directory
alias resolve='cd "`pwd -P`"'

# simple python webserver
alias py2serv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias pyserv="py3serv"

# How much memory is Chrome using right now?
alias chromemem="ps -ev | grep -i chrome | awk '{print \$12}' | awk '{for(i=1;i<=NF;i++)s+=\$i}END{print s}'"

# Remove garbage files
alias purgeswp="find . -regex '.*.swp$' | xargs rm"
alias purgedrive='find ~/GoogleDrive/ -name Icon -exec rm -f {} \; -print'
alias purgeicon='find . -name Icon -exec rm -f {} \; -print'

# I don't care if Homebrew thinks this is bad, it's super convenient
alias sudo-htop='sudo chown root:wheel $(which htop) && sudo chmod u+s $(which htop)'

AG_DARK="ag --color-path '0;35' --color-match '1;37' --color-line-number '0;34'"
AG_LIGHT="ag --color-path '0;35' --color-match '1;30' --color-line-number '0;34'"
if [ "$SOLARIZED" = "dark" ]; then
  alias ag="$AG_DARK"
elif [ "$SOLARIZED" = "light" ]; then
  alias ag="$AG_LIGHT"
else
  alias ag="$AG_DARK"
fi
alias agt="ag --ignore='*test*'"


# ----- Git aliases -----------------------------------------------------------

# hub is a command line wrapper for using Git with GitHub
eval "$(hub alias -s 2> /dev/null)"

# We want to use '#' as a markdown character, so let's use '%' for comments
alias hubmdpr="hub -c core.commentChar='%' pull-request"
alias hubmd="hub -c core.commentChar='%'"

alias git-skip-dirty-check="export PROMPT_PURE_SKIP_DIRTY_CHECK='1'"
alias git-check-dirty="unset PROMPT_PURE_SKIP_DIRTY_CHECK"
alias git-personal-ssh="git config core.sshCommand 'ssh -i ~/.ssh/id_rsa -F /dev/null'"

# for use with `git files` and `git review` aliases in gitconfig
export REVIEW_BASE='master'

alias gco="git checkout"
alias gob="git checkout -b"
alias goB="git checkout -B"

alias ga="git add"
alias gap="git add --patch"

alias gc="git commit -v"
alias gca="gc -a"
alias gcmd="git -c core.commentChar='%' commit -v --template=$HOME/.util/gitmessage.md"
alias gcm="git commit -m"
alias gcam="git commit -am"

alias gs="git status"
alias gd="git diff"
alias gdw="git diff --color-words"
alias gds="git icdiff"

alias gf="git fetch"
alias gfp="git fetch --prune"
alias gpf="git pull --ff-only"

# resuable format strings
GIT_PRETTY_FORMAT="--pretty=\"%C(bold green)%h%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_AUTHOR="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_ALIGN="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset %s%C(auto)%d%Creset\""

# pretty Git log
alias gl="git log --graph $GIT_PRETTY_FORMAT"
# pretty Git log, all references
alias gll='gl --all'
# pretty Git log, show authors
alias gla="git log --graph $GIT_PRETTY_FORMAT_AUTHOR"
# pretty Git log, all references, show authors
alias glla='gla --all'
# pretty Git log, show authors, align messages
alias glala="git log --graph $GIT_PRETTY_FORMAT_ALIGN"
# pretty Git log, all references, show authors, align messages
alias glalal="glala --all"


# ----- Docker aliases --------------------------------------------------------

# docker-compose is far too long to type
alias fig="docker-compose"

alias clean-containers='docker rm -v $(docker ps -a -q -f status=exited)'
alias clean-images='docker rmi $(docker images -q -f dangling=true)'
# TODO: alias clean-volumes='...'

# ----- Linux specific --------------------------------------------------------

# it doesn't make sense to repeat this for each specific host;
# it's Linux specific
if [ "$(uname)" = "Linux" ]; then
  which tree &> /dev/null && alias tree="tree -C -F --dirsfirst"
else
  which tree &> /dev/null && alias tree="tree -F --dirsfirst"
fi

# if tree doesn't exist, the return condition will be false when we exit
true
