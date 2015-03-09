
# hacks to run before everything else

# greatwhite.ics.cs.cmu.edu is far too old for anything I'd want to do
[[ $(hostname) =~ greatwhite ]] && exit

# ensure that these directories are available to us
export PATH=".:$HOME/bin:/usr/local/bin:$PATH"
