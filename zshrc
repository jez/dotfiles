#
# .zshrc - How I configure zsh
#
# This is just a skeleton; the real heavy lifting is done by various
# compartmentalized scripts, which are all sourced by this file. Inspired by
# Zach Holman's dotfiles organization.
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
  # local start=$(date +%s%N)
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
  # local end=$(date +%s%N)
  # 2>&1 printf "$@: %.3f ms\n" "$(((end - start) / 1000000.0))"
}

# Make sure we are running interactively, else stop
[ -z "$PS1" ] && return

# Hacks to override things before starting
load_module ~/.util/host_before.sh

# Hacks to override things before starting
load_module ~/.util/before.sh

# Load utility colors
load_module ~/.util/colors.sh

# Remind the user to update and provide mechanism for updating easily
#load_module ~/.util/auto-update.sh

# zsh-specific settings
load_module ~/.util/misc.zsh

# host-specific settings. This file changes per host according to rcm.
load_module ~/.util/host.sh

# Host-independent aliases
load_module ~/.util/aliases.sh

# host-specific zsh settings.
load_module ~/.util/host.zsh

# miscellaneous, shell-agnostic settings
load_module ~/.util/misc.sh

# prompt settings
load_module ~/.util/prompt.zsh

# Hacks to override things after finishing
load_module ~/.util/after.sh

# load helper functions
for module in ~/.util/functions/*.sh; do
  load_module $module
done

# STRIPE_DO_NOT_MANAGE=1
