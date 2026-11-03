# Login shells only. Read ~/.profile, like bash does, for login PATH setup that
# must run after macOS's /etc/zprofile, whose path_helper moves the system
# directories ahead of everything .zshenv added. See host.profile.
if [[ "$OSTYPE" == darwin* ]] && [ -f ~/.profile ]; then
  source ~/.profile
fi

# `export PATH=...:$PATH` in sh syntax doesn't trigger zsh's `typeset -U path`.
# Reassigning the array drops later duplicates, keeping the order just set up.
path=($path)
