#
# colors.sh - convenient shortcut variables for common shell colors
#
# Usage:
#   Once you've sourced this file,
#
#       echo "This word is${cblue}blue${cnone} :D"
#
#   This works anywhere that shell variables are expanded.

# ANSI colors
export cnone=$'\x1b[0m'
export cwhiteb=$'\x1b[1;37m'
export cwhite=$'\x1b[0;37m'
export cgray=$'\x1b[1;30m'
export cblack=$'\x1b[0;30m'

export cred=$'\x1b[0;31m'
export credb=$'\x1b[1;31m'
export cgreen=$'\x1b[0;32m'
export cgreenb=$'\x1b[1;32m'
export cyellow=$'\x1b[0;33m'
export cyellowb=$'\x1b[1;33m'
export cblue=$'\x1b[0;34m'
export cblueb=$'\x1b[1;34m'
export cmagenta=$'\x1b[0;35m'
export cmagentab=$'\x1b[1;35m'
export ccyan=$'\x1b[0;36m'
export ccyanb=$'\x1b[1;36m'

# Solarized 256 colors
export sred=$'\x1b[00;38;5;160m'
export sorange=$'\x1b[00;38;5;166m'
export syellow=$'\x1b[00;38;5;136m'
export sgreen=$'\x1b[00;38;5;64m'
export sblue=$'\x1b[00;38;5;33m'
export spurple=$'\x1b[00;38;5;61m'
export sbgray=$'\x1b[01;38;5;245m'
export slgray=$'\x1b[00;38;5;244m'
export sfaint=$'\x1b[00;38;5;240m'
export swhite=$'\x1b[00;38;5;15m'
export sreset=$'\x1b[0m'

# Utility function to pick any xterm-256 color
# Usage:
#   $(color256 fg attr bg)
#   fg - 256 xterm color code
#   attr - one of:
#        - 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
#   bg - 256 xterm color code
# You may omit either (bg) or (style and bg)
function color256 () {
  if [ -z $3 ]; then echo -ne "\033[$2;48;5;$3;38;5;$1m"; return; fi
  if [ -z $2 ]; then echo -ne "\033[$2;38;5;$1;40m"; return; fi
  if [ -z $1 ]; then echo -ne "\033[0;38;5;$1;40m"; return; fi
}
