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
    /Users/jez/psb) ;&
    /Users/jez/psb/*) ;&
    /Users/jez/stripe/pay-server) ;&
    /Users/jez/stripe/pay-server/*) ;&
    /Users/jez/stripe-b/pay-server) ;&
    /Users/jez/stripe-b/pay-server/*) ;&
    /Users/jez/stripe/ps-worktree) ;&
    /Users/jez/stripe/ps-worktree/*) ;&
    /Users/jez/zoolander) ;&
    /Users/jez/zoolander/*) ;&
    /Users/jez/stripe/zoolander) ;&
    /Users/jez/stripe/zoolander/*) ;&
    /Users/jez/gocode) ;&
    /Users/jez/gocode/*) ;&
    /Users/jez/stripe/gocode) ;&
    /Users/jez/stripe/gocode/*) ;&
    /Users/jez/stripe/puppet-config) ;&
    /Users/jez/stripe/puppet-config/*) ;&
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
