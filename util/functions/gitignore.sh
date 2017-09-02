# Create useful gitignore files
# Usage: gi [param]
# param is a comma separated list of ignore profiles.
# If param is ommited choose interactively.

gitignore() {
  api="curl -L -s https://www.gitignore.io/api"

  if [ "$#" -eq 0 ]; then
    result="$(eval "$api/list" | tr ',' '\n' | fzf --reverse --multi --preview "$api/{} | highlight --syntax python -O ansi" | paste -s -d "," -)"
    [ -n "$result" ] && eval "$api/$result"
  else
    $api/$*
  fi
}
