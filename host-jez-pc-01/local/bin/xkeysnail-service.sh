#!/usr/bin/env bash

set -euo pipefail

# To debug, some things which are useful:
#
# - vim /home/jez/.config/systemd/user/xkeysnail.service
# - journalctl --follow --user-unit xkeysnail.service

/usr/bin/xhost +SI:localuser:root

# Using the --quiet option otherwise this acts as a keylogger of every keystroke.
# To debug, you can either delete that temporarily or stop the service and run
# it manually in your terminal.
quiet="--quiet"
if [ -t 0 ] && [ -t 1 ]; then
  # We're probably in a terminal, so let's disable quiet
  quiet=""
fi
exec /usr/local/bin/xkeysnail $quiet --watch /home/jez/.config/xkeysnail/config.py
