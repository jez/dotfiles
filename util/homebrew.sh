# Shared environment setup for Bash and Zsh, including noninteractive shells.
setup_homebrew() {
  local prefix shellenv

  # shellenv exports HOMEBREW_PREFIX along with PATH. Child shells inherit both,
  # so initialize once rather than prepending the same directories again.
  [ -z "${HOMEBREW_PREFIX:-}" ] || return 0

  # Standard Apple Silicon, Linux, Intel Mac, and per-user Linux installations.
  for prefix in /opt/homebrew /home/linuxbrew/.linuxbrew /usr/local "$HOME/.linuxbrew"; do
    [ -x "$prefix/bin/brew" ] || continue

    # shellenv emits nothing if Homebrew already leads PATH. Give its subprocess
    # a clean PATH so it always emits the other environment variables too.
    # Request sh syntax explicitly: $SHELL may differ from the running shell.
    shellenv=$(PATH=/usr/bin:/bin "$prefix/bin/brew" shellenv sh) || return
    eval "$shellenv"
    return 0
  done
}

setup_homebrew
unset -f setup_homebrew
