
_fzf_complete_lldb() {
  local tokens
  tokens=(${(z)LBUFFER})

  if [ ${#tokens[@]} -ge 3 ] && [ "${tokens[2]}" = "-p" ]; then
    _fzf_complete_kill "$@"
  fi
}


