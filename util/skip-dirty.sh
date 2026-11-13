#
# skip-dirty.sh - Skip dirty, unless the path matches certain patterns
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file, then call skip_dirty_check whenever $PWD changes (zsh:
#   chpwd_functions, bash: PROMPT_COMMAND). Read by the zsh and bash prompts.
#   Plain `|` patterns, not zsh's `;&`, which macOS's /bin/bash 3.2 lacks.
#

skip_dirty_check() {
  case $PWD in
    /Users/jez/ps|/Users/jez/ps/*|\
    /Users/jez/mint|/Users/jez/mint/*|\
    /Users/jez/stripe/mint|/Users/jez/stripe/mint/*|\
    /pay/src/pay-server|/pay/src/pay-server/*|\
    /Users/jez/stripe/github/vscode|/Users/jez/stripe/github/vscode/*)
      export PROMPT_PURE_SKIP_DIRTY_CHECK=1
      ;;
    *)
      unset PROMPT_PURE_SKIP_DIRTY_CHECK
      ;;
  esac
}
