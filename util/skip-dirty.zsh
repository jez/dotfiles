#
# skip-dirty.sh - Skip dirty, unless the path matches certain patterns
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#

function chpwd() {
  case $PWD in
    /Users/jez/ps) ;&
    /Users/jez/ps/*) ;&
    /Users/jez/stripe/pay-server) ;&
    /Users/jez/stripe/pay-server/*) ;&
    /Users/jez/stripe/checkout) ;&
    /Users/jez/stripe/checkout/*) ;&
    /Users/jez/prog/pl/flow) ;&
    /Users/jez/prog/pl/flow/*) ;&
    /Users/jez/dbx/Documents/Programming/pl/flow) ;&
    /Users/jez/dbx/Documents/Programming/pl/flow/*) ;&
    PROMPT_PURE_SKIP_DIRTY_CHECK)
      export PROMPT_PURE_SKIP_DIRTY_CHECK=1
      ;;
    *)
      unset PROMPT_PURE_SKIP_DIRTY_CHECK
      ;;
  esac
}
