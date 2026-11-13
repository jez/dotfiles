#!/bin/sh
#
# Helpers that let herdr keybindings mimic ~/.config/tmux/tmux.conf.
# Invoked from [[keys.command]] entries in ~/.config/herdr/config.toml.
#
# Usage:
#   tmux-compat.sh navigate <left|down|up|right> <key>
#   tmux-compat.sh split <right|down> <cells> [before|keep]
#   tmux-compat.sh new-tab
#   tmux-compat.sh break-pane
#   tmux-compat.sh send-keys <key>

set -eu

pane="${HERDR_ACTIVE_PANE_ID:?must be run from a herdr keybinding}"

case "$1" in
  # vim-tmux-navigator: if Vim is in the foreground, forward the key so Vim can
  # move between its own splits (and call back out to herdr at the edge).
  # Same process match as `is_vim` in ~/.config/tmux/new-navigator.conf.
  navigate)
    if herdr pane process-info --pane "$pane" |
        jq -e '.result.process_info.foreground_processes[].name |
               select(test("^g?(view|n?vim?x?)(diff)?$"))' > /dev/null; then
      herdr pane send-keys "$pane" "$3"
    else
      # Fails harmlessly when there's no pane in that direction.
      herdr pane focus --pane "$pane" --direction "$2" > /dev/null 2>&1 || true
    fi
    ;;

  # Like `split-window -l <cells>` (and `-b` when "before" is given).
  # "keep" instead leaves the original pane <cells> big, with the new pane
  # after it: the same layout as "before", minus the swap.
  # herdr's --ratio is the share the *original* pane keeps.
  split)
    direction=$2
    cells=$3
    if [ "$direction" = right ]; then dim=width; else dim=height; fi
    total=$(herdr pane layout --pane "$pane" |
      jq --arg p "$pane" --arg d "$dim" '.result.layout.panes[] | select(.pane_id == $p) | .rect[$d]')
    ratio=$(awk -v n="$cells" -v t="$total" -v b="${4:-}" 'BEGIN {
      r = (b == "before" || b == "keep") ? n / t : 1 - n / t
      if (r < 0.1) r = 0.1
      if (r > 0.9) r = 0.9
      print r
    }')
    new=$(herdr pane split --pane "$pane" --direction "$direction" --ratio "$ratio" --focus |
      jq -r '.result.pane.pane_id')
    if [ "${4:-}" = before ]; then
      herdr pane swap --source-pane "$new" --target-pane "$pane" > /dev/null
    fi
    ;;

  # Like `new-window`, then `split left` (prefix+<) on wide screens or
  # `split right` (prefix+>) on narrow ones.
  new-tab)
    new=$(herdr tab create --workspace "${pane%%:*}" --focus |
      jq -r '.result.root_pane.pane_id')
    width=$(herdr pane layout --pane "$new" | jq '.result.layout.area.width')
    if [ "$width" -ge 300 ]; then
      HERDR_ACTIVE_PANE_ID=$new exec "$0" split right 108 before
    else
      HERDR_ACTIVE_PANE_ID=$new exec "$0" split right 83
    fi
    ;;

  # Like `break-pane`: move the focused pane into its own tab.
  break-pane)
    herdr pane move "$pane" --new-tab --focus > /dev/null
    ;;

  send-keys)
    herdr pane send-keys "$pane" "$2"
    ;;

  *)
    echo "tmux-compat.sh: unknown command: $1" >&2
    exit 1
    ;;
esac
