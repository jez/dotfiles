
## Open Matching
# grep for non-binary files matching a pattern and open them in vim tabs
# will automatically search for the specified regexp
#
# NOTE: I'm pretty sure this is broken in zsh
#
om() {
  local pattern="$@"
  local result="`grep -l -r --binary-files=without-match "$pattern" * | tr '\n' ' '`"
  if [ -n "$result" ]; then
    vim -p -c "/$pattern" $result
  else
    echo "${cwhiteb}No files matching the pattern: $sred$pattern$cnone"
  fi
}
