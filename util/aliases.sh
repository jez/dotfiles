
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

alias bex="bundle exec"

# I'm pretty proud of these ones
alias :q="clear"
alias :qall!="clear"
alias :tabe="vim"
alias :Vs="vimv"
alias :vs="vimv"

# Redirect stderr and stdout when using GRC
which grc &> /dev/null && alias grc="grc -es"

# look up LaTeX documentation
which texdef &> /dev/null && alias latexdef="texdef --tex latex"

# Easily download an MP3 from youtube on the command line
alias youtube-mp3="noglob youtube-dl --extract-audio --audio-format mp3"

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

# Show a summary of my jrnl. 'viewjrnl' is defined in https://github.com/jez/bin
alias jrnlsum="viewjrnl -from '10 days ago'"

# CMake
alias cmg="cmake -S . -B build -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug"
alias cm="cmake --build build"

alias cmr="cmake -S . -B build-release -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo"
alias cmrb="cmake --build build-release"

# ----- aliases that are actually full-blown commands -------------------------

# list disk usage statistics for the current folder
alias duls="du -h -d1 | sort -hr"

# print my IP
alias ip="curl ifconfig.co"
alias ipv4="curl -4 ifconfig.co"
alias ipv6="curl -6 ifconfig.co"

# resolve a symlink in the PWD to a fully qualified directory
alias resolve='cd "`pwd -P`"'

# simple python webserver
alias py2serv="python -m SimpleHTTPServer"
alias py3serv="python3 -m http.server"
alias pyserv="py3serv"

# How much memory is Chrome using right now?
alias chromemem="ps -ev | grep -i chrome | awk '{print \$12}' | awk '{for(i=1;i<=NF;i++)s+=\$i}END{print s}'"

# Re-export SSH_AUTH_SOCK using value from outside tmux
alias reauthsock='eval "export $(tmux showenv SSH_AUTH_SOCK)"'

# Remove garbage files
alias purgeswp="find . -regex '.*.swp$' | xargs rm"
alias purgedrive='find ~/GoogleDrive/ -name Icon -exec rm -f {} \; -print'
alias purgeicon='find . -name Icon -exec rm -f {} \; -print'

# I don't care if Homebrew thinks this is bad, it's super convenient
alias sudo-htop='sudo chown root:wheel $(which htop) && sudo chmod u+s $(which htop)'

AG_DARK="ag --hidden --color-path '0;35' --color-match '1;37' --color-line-number '0;34'"
AG_LIGHT="ag --hidden --color-path '0;35' --color-match '1;30' --color-line-number '0;34'"
if [ "$SOLARIZED" = "dark" ]; then
  alias ag="$AG_DARK"
elif [ "$SOLARIZED" = "light" ]; then
  alias ag="$AG_LIGHT"
else
  alias ag="$AG_DARK"
fi
alias agt="ag --ignore='*test*'"
alias ago="ag --nobreak --noheading --nofilename --nogroup --only-matching"

RG_DARK="rg -S --hidden --colors 'match:fg:white' --colors 'match:style:bold' --colors 'line:fg:blue'"
RG_LIGHT="rg -S --hidden --colors 'match:fg:black' --colors 'match:style:bold' --colors 'line:fg:blue'"
if [ "$SOLARIZED" = "dark" ]; then
  alias rg="$RG_DARK"
elif [ "$SOLARIZED" = "light" ]; then
  alias rg="$RG_LIGHT"
else
  alias rg="$RG_DARK"
fi
alias rgt=$'rg --glob=\'!test\''
alias rgo="rg --no-heading --no-filename --no-line-number --only-matching"

alias gg="git grep"

alias payweb-time="overtime show Europe/Berlin Europe/London America/New_York America/Denver America/Los_Angeles"

# Takes output like 'foo.txt:12: ...' (i.e., output from git grep --line)
# and keeps only the foo.txt:12 part
alias fileline="cut -d : -f 1-2"
alias onlyloclines="sed -e '/^ /d; /^$/d; /^Errors:/d'"
alias onlylocs="onlyloclines | fileline"

# Given input like foo.txt:12 on their own lines, +1 / -1 to all the line numbers
alias nextline="awk 'BEGIN { FS = \":\"} {print \$1 \":\" (\$2 + 1)}'"
alias prevline="awk 'BEGIN { FS = \":\"} {print \$1 \":\" (\$2 - 1)}'"

# ----- Git aliases -----------------------------------------------------------

# hub is a command line wrapper for using Git with GitHub
eval "$(hub alias -s 2> /dev/null)"

# We want to use '#' as a markdown character, so let's use '%' for comments
alias hubmdpr="hub -c core.commentChar='%' pull-request"
alias hubmd="hub -c core.commentChar='%'"
alias hubci="hub ci-status --verbose"
alias ptal='hub issue update "$(hub pr show --format="%I")" -a'

alias git-skip-dirty-check="export PROMPT_PURE_SKIP_DIRTY_CHECK='1'"
alias git-check-dirty="unset PROMPT_PURE_SKIP_DIRTY_CHECK"
alias git-personal-ssh="git config core.sshCommand 'ssh -i ~/.ssh/id_rsa -F /dev/null'"

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
alias gcan="git commit -a --amend --no-edit"
alias gcne="git commit --amend --no-edit"

alias gs="git status"
alias gss="git status --short"
alias gd="git diff"
alias gdd="git diff"
alias gds="git diff --staged"
alias gdw="git diff --color-words"
alias gdr="git diff-review"
alias gbc="git by-commit"
alias gicd="git icdiff"

alias gf="git fetch"
alias gfp="git fetch --prune"
alias gpf="git pull --ff-only"

alias grbc="git rebase --continue"
alias gri="git rebase -i"
alias grim="git rebase -i master"

alias gr="git review"
alias gro="git reviewone"
alias grf="git reviewf"

alias gitprune='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch\^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'

# resuable format strings
# GIT_PRETTY_FORMAT_AUTHOR="--pretty=\"%C(auto)%cs%Creset %C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_AUTHOR="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset%C(auto)%d%Creset %s\""
GIT_PRETTY_FORMAT_ALIGN="--pretty=\"%C(bold green)%h%Creset %C(yellow)%an%Creset %s%C(auto)%d%Creset\""

# only branches with 'jez' in them, including their remote counter parts
# (especially useful when in a repo with lots of other people)
ONLY_JEZ="--branches='*jez*' --remotes='*jez*' master origin/master"

# exclude tags (Sorbet tags are super annoying)
EXCLUDE_TAGS="--decorate-refs-exclude='tags/*'"

# pretty Git log, show authors
alias glat="git log --graph $GIT_PRETTY_FORMAT_AUTHOR"
# pretty Git log, all references, show authors
alias gllat='glat --all'
# pretty Git log, show authors, align messages
alias glalat="git log --graph $GIT_PRETTY_FORMAT_ALIGN"
# pretty Git log, all references, show authors, align messages
alias glalalt="glala --all"

# It doesn't make sense to combine $ONLY_JEZ with --all
alias glajt="glat $ONLY_JEZ"
alias glalajt="glalat $ONLY_JEZ"

# non-tag versions of the above
alias gla="glat $EXCLUDE_TAGS"
alias glla="gllat $EXCLUDE_TAGS"
alias glala="glalat $EXCLUDE_TAGS"
alias glalal="glalalt $EXCLUDE_TAGS"
alias glaj="glajt $EXCLUDE_TAGS"
alias glalaj="glalajt $EXCLUDE_TAGS"

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
