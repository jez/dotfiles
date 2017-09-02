# Use fzf to browse a file's git history

ghist() {
  [ -z "$1" ] && echo "ERR: History for which file?" && return 1
  git log --oneline "$1" | fzf --preview "git show {+1}:\"$1\" | highlight --force -O ansi -l -S \"\${\$(basename $1)##*.}\""
}
