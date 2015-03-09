
# The prompt settings in this file are an exception to the
# compartmentalization. I use zsh in favor of bash now, and didn't feel like
# spending the effort to making this prompt file play nicely with the rest of
# my dotfiles. This might be easy using rcm, but I didn't try.
#

color_my_prompt() {
  # To color each machine's prompt differently
  case $HOSTNAME in
    *MacBook*)
      local prompt_dir_color="$cmagentab"
      ;;
    *andrew*|*gates*|*shark*)
      local prompt_dir_color="${cgreen}"
      ;;
    alarmpi)
      local prompt_dir_color="${cblue}"
      ;;
    jake-raspi)
      local prompt_dir_color="${cmagenta}"
      ;;
    *xubuntu*)
      local prompt_dir_color="${cyan}"
      ;;
    pop.scottylabs.org)
      local prompt_dir_color="${cyellow}"
      ;;
    scottylabs)
      local prompt_dir_color="$credb"
      ;;
    metagross)
      local prompt_dir_color="${cblue}"
      ;;
    *)
      local prompt_dir_color="${cred}"
      ;;
  esac

  # change the color of the git branch depending on whether the repo is "messy" or "clean"
  local __git_branch_color='$(if [ -z "$(git status --porcelain 2> /dev/null)" ]; then echo \[${cgreen}\]; else echo \[${cyellow}\]; fi)'

  local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'

  if [ $(id -u) -eq 0 ]; then
    local __prompt_tail="\[$cred\]#\[$cnone\]";
  else
    local __prompt_tail="\[$ccyan\]$(echo -en '\xe2\x9d\xaf')\[${cnone}\]";
  fi

  export PS1="\n\[$prompt_dir_color\]\w\[${cnone}\] $__git_branch_color$__git_branch\[$cnone\]\n$__prompt_tail "
}
color_my_prompt
#echo -n '.'

# Turn the color back to normal after the command executes
#trap 'echo -ne "\033[0m"' DEBUG
#echo -en '.\r'
