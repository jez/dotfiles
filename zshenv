typeset -U path

fpath=( "$HOME/.zfunctions" $fpath )

case `hostname` in
  *Jacobs-MacBook-Air*)
    ;;
  *andrew*)
    aklog cs.cmu.edu
    ;;
  alarmpi)
    ;;
  jake-raspi)
    ;;
  *xubuntu*)
    ;;
  pop.scottylabs.org)
    ;;
  scottylabs)
    ;;
  ghost.zimmerman.io)
    ;;
  *)
    ;;
esac
