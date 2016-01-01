agc() {
  ag --color --group $@ | cut -c -100
}
