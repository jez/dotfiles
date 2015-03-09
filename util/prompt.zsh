
# prompt defaults, unless these have already been overridden
[ -z "$PROMPT_PURE_SUCCESS_COLOR" ] && PROMPT_PURE_SUCCESS_COLOR="%F{cyan}"
[ -z "$PROMPT_PURE_NO_SUBMODULES" ] && PROMPT_PURE_NO_SUBMODULES="--ignore-submodules"
[ -z "$PROMPT_PURE_DIR_COLOR" ] && PROMPT_PURE_DIR_COLOR="%F{red}"
[ -z "$PURE_NO_SSH_USERNAME" ] && PURE_NO_SSH_USERNAME=1
[ -z "$PURE_GIT_PULL" ] && PURE_GIT_PULL=0

prompt pure
