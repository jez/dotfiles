typeset -U path

fpath=( "$HOME/.zfunctions" $fpath )

path=(/usr/local/share/npm/bin $path)
path=($HOME/.rvm/bin $path)
path=($HOME/local/bin $path)
path=($path /usr/local/texlive/2013/bin/x86_64-darwin)
path=($HOME/.cabal/bin $path)

