
# ----- General ---------------------------------------------------------------

# colorize grep and ls
alias grep="grep --color=auto"
alias ls="ls -p --color=auto"
alias l="ls"

# manipulate files verbosely (print log of what happened)
alias cp="cp -v"
alias mv="mv -v"
alias rm="rm -v"

# so much easier to type than `cd ..`
alias cdd="cd .."
alias cddd="cd ../.."
alias cdddd="cd ../../.."

# open multiple files in Vim tabs
alias vim="vim -p"

# Redirect stderr and stdout when using GRC
which grc &> /dev/null && alias grc="grc -es"

# look up LaTeX documentation
which texdef &> /dev/null && alias latexdef="texdef --tex latex"

# Easily download an MP3 from youtube on the command line
which youtube-dl &> /dev/null && alias youtube-mp3="youtube-dl --extract-audio --audio-format mp3"

# ----- aliases that are actually full-blown commands -------------------------

# list disk usage statistics for the current folder
alias duls="du -h -d1 | sort -hr"

# print my IP
alias ip="curl curlmyip.com"

# resolve a symlink in the PWD to a fully qualified directory
alias resolve='cd "`pwd -P`"'

# simple python webserver
alias py2serv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias pyserv="py3serv"

# How much memory is Chrome using right now?
alias chromemem="ps -ev | grep -i chrome | awk '{print \$12}' | awk '{for(i=1;i<=NF;i++)s+=\$i}END{print s}'"

# Remove garbage files
alias purgeswp="find . -regex '.*.swp$' -exec rm {}"
alias purgedrive='find ~/GoogleDrive/ -name Icon -exec rm -f {} \; -print'
alias purgeicon='find . -name Icon -exec rm -f {} \; -print'


# ----- Git aliases -----------------------------------------------------------

# hub is a command line wrapper for using Git with GitHub
eval "$(hub alias -s 2> /dev/null)"

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

alias gf="git fetch"
alias gfp="git fetch --prune"

# resuable format strings
GIT_PRETTY_FORMAT="--pretty=\"%C(bold green)%h%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_AUTHOR="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s\""

# pretty Git log
alias gl="git log --graph $GIT_PRETTY_FORMAT"
# pretty Git log, all references
alias gll='gl --all'
# pretty Git log, show authors
alias gla="git log --graph $GIT_PRETTY_FORMAT_AUTHOR"
# pretty Git log, all references, show authors
alias glla='gla --all'

# ----- Linux specific --------------------------------------------------------

# it doesn't make sense to repeat this for each specific host;
# it's Linux specific
if [ $(uname) = "Linux " ]; then
  which tree &> /dev/null && alias tree="tree -C -F --dirsfirst"
fi
