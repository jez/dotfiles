#
# .bash_profile - How I configure bash
#
# This is just a skeleton; the real heavy lifting is done by various
# compartmentalized scripts, which are all sourced by this file. Inspired by
# Zach Holman's dotfiles organization.
#
# The prompt settings in this file are an exception to the
# compartmentalization. I use zsh in favor of bash now, and didn't feel like
# spending the effort to making the two `prompt.sh` functions place nicely
# together. This might be possible using rcm, but I didn't try.
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   This file requires that many helper files are in place for it to work
#   correctly. Read the README for more information.
#

# load a module robustly by skipping all remaining modules if any module fails
# to load
load_module() {
  if [ -n "$ABORTED" ]; then
    return
  fi

  module="$1"
  if [ -f "$module" ]; then
    source $module

    if [ "$?" != "0" ]; then
      echo "Module $module failed to load. Exiting."
      export ABORTED=1
      return
    fi
  fi
}

# Make sure we are running interactively, else stop
[ -z "$PS1" ] && return

# Hacks to override things before starting
load_module ~/.util/before.sh

# Load utility colors
load_module ~/.util/colors.sh

# Remind the user to update and provide mechanism for updating easily
load_module ~/.util/auto-update.sh

# bash-specific settings
load_module ~/.util/misc.bash

# Host-independent aliases
load_module ~/.util/aliases.sh

# host-specific settings. This file changes per host according to rcm.
load_module ~/.util/host.sh

# miscellaneous, shell-agnostic settings
load_module ~/.util/misc.sh

# load helper functions
for module in ~/.util/functions/*.sh; do
  load_module $module
done

# ----- set the PS1 variable -------------------------------------------------
color_my_prompt() {
  # To color each machine's prompt differently
  case $HOSTNAME in
    *MacBook*)
      local prompt_dir_color="$cmagentab"
      ;;
    *andrew*|*gates*|*shark*)
      local prompt_dir_color="${cgreen}"
      ;;
    alarmpi)
      local prompt_dir_color="${cblue}"
      ;;
    jake-raspi)
      local prompt_dir_color="${cmagenta}"
      ;;
    *xubuntu*)
      local prompt_dir_color="${cyan}"
      ;;
    pop.scottylabs.org)
      local prompt_dir_color="${cyellow}"
      ;;
    scottylabs)
      local prompt_dir_color="$credb"
      ;;
    metagross)
      local prompt_dir_color="${cblue}"
      ;;
    *)
      local prompt_dir_color="${cred}"
      ;;
  esac

  # change the color of the git branch depending on whether the repo is "messy" or "clean"
  local __git_branch_color='$(if [ -z "$(git status --porcelain 2> /dev/null)" ]; then echo \[${cgreen}\]; else echo \[${cyellow}\]; fi)'

  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

  if [ $(id -u) -eq 0 ]; then
    local __prompt_tail="\[$cred\]#\[$cnone\]";
  else
    local __prompt_tail="\[$ccyan\]$(echo -en '\xe2\x9d\xaf')\[${cnone}\]";
  fi

  export PS1="\n\[$prompt_dir_color\]\w\[${cnone}\] $__git_branch_color$__git_branch\[$cnone\]\n$__prompt_tail "
}
color_my_prompt
#echo -n '.'

# Turn the color back to normal after the command executes
#trap 'echo -ne "\033[0m"' DEBUG
#echo -en '.\r'
