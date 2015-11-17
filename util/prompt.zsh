#
# prompt.zsh - My prompt-specific configuration for zsh
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#
# Notes
#   I use a 3rd-party prompt called 'pure' by sindresorhus. A while back I
#   forked it to add features related to configuring the colors of various
#   elements of the prompt, as well as to modify bits related to how the Git
#   statuses are reported.
#
#   You can find the source code online here[1], and the original fork here[2].
#
#   For this to work, you'll have to make sure that the 'pure' prompt plugin is
#   in your zsh 'fpath' somewhere. In particular, I set my fpath (in ~/.zshenv)
#   to include the folder ~/.zfunctions/, which is the folder where the clone
#   of [1] resides.
#
#   [1]: https://github.com/jez/pure
#   [2]: https://github.com/sindresorhus/pure
#
# TODOs
#   - n/a

# These are all jez/pure-specific configuration options
[ -z "$PROMPT_PURE_SUCCESS_COLOR" ] && PROMPT_PURE_SUCCESS_COLOR="%F{cyan}"
[ -z "$PROMPT_PURE_NO_SUBMODULES" ] && PROMPT_PURE_NO_SUBMODULES="--ignore-submodules"
[ -z "$PROMPT_PURE_DIR_COLOR" ] && PROMPT_PURE_DIR_COLOR="%F{red}"
[ -z "$PURE_NO_SSH_USERNAME" ] && PURE_NO_SSH_USERNAME=1
# This is a sindresorhus/pure configuration option
[ -z "$PURE_GIT_PULL" ] && PURE_GIT_PULL=0

prompt pure
