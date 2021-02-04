#
# host.zsh - Host-specific, zsh-specific configurations
#
# Author
#   Jake Zimmerman <jake@zimmerman.io>
#
# Usage
#   Source this file.
#
# TODOs
#   - n/a


source ~/.util/fzf.zsh
source ~/.util/bazel.zsh

# Not needed yet.
# source ~/.util/skip-dirty.zsh

# OPAM configuration
source ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
