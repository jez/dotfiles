#
# auto-update.sh - check for updates (to anything) regularly
#
# Can be used for things like checking if dotfiles repos have new changes, if
# package managers have updates, renewing credentials, etc.
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   - Requires my colors.sh to have been sourced already for colorized output
#   - source this file to check if the "system is out of date" (i.e., hasn't
#     been updated in UPDATE_THRESHOLD seconds)
#   - call `update` to run general update checks and checks defined by the
#     system
#     - define a function `update-host` and bind it to the environment before
#       calling update!
#
# Notes
#   This file will only check for updates every time it's sourced. It's meant
#   to be sourced in a bashrc or zshrc so that every time you open a new tab or
#   pane it reminds you if you haven't updated in a while. It neither checks
#   continuously for updates, nor fetches the updates themselves.
#
# TODOs
#   Maybe some day I'll turn this into a fully-configurable file, but for now
#   most things are hard coded.

# Number of seconds to wait before printing a reminder
UPDATE_THRESHOLD="86400"

[ ! -e $HOME/.last_update ] && touch $HOME/.last_update
# Initialize for when we have no GNU date available
last_check=0
time_now=0

last_check_string=$(ls -l $HOME/.last_update | awk '{print $6" "$7" "$8}')

# Darwin uses BSD, check for gdate, else use date
if [[ $(uname) = "Darwin" && -n $(which gdate) ]]; then
  last_login=$(gdate -d"$last_check_string" +%s)
  time_now=$(gdate +%s)
else
  # Ensure this is GNU grep
  if [ -n "$(date --version 2> /dev/null | grep GNU)" ]; then
    last_login=$(date -d"$last_check_string" +%s)
    time_now=$(date +%s)
  fi
fi

time_since_check=$((time_now - last_login))

if [ "$time_since_check" -ge 86400 ]; then
  echo "$cred==>$cwhiteb Your system is out of date!$cnone"
  echo 'Run `update` to bring it up to date.'
fi

# update - fetch updates
# usage:
#   update
#
# You will likely also want to define a function `update-host` for each host
# that you will run `update` from. Ensure that this function is sourced before
# calling `update`.
update() {
  # Record that we've update
  touch $HOME/.last_update

  # --- Host-independent updates ---

  # Update dotfiles repo
  cd ~/.dotfiles/
  echo "$cblueb==>$cwhiteb Updating dotfiles...$cnone"
  git fetch --quiet origin
  if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/master)" ]; then echo "$credb  --> outdated.$cnone"; fi

  # Update each submodule in the dotfiles repo
  echo "$cblueb==>$cwhiteb Checking for outdated dotfiles submodules...$cnone"
  git submodule foreach --quiet 'git fetch --quiet && if [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/master)" ]; then echo $path; fi'
  cd - &> /dev/null

  # --- Host-dependent updates ---

  update-host
}
