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
source ~/.util/skip-dirty.zsh

autoload -U +X bashcompinit && bashcompinit
complete -C /Users/jez/stripe/space-commander/bin/commands/sc-complete sc
complete -C /Users/jez/stripe/space-commander/bin/commands/sc-complete _sc
