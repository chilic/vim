#!/usr/bin/env bash

msg() {
  printf '%b\n' "$1" >&2 
}

ok() {
  if [ "$ret" -eq '0' ]; then
    msg "\33[32m[✔]\33[0m ${1}${2}"
  fi
}

err() {
  msg "\33[31m[✘]\33[0m ${1}${2}"
  exit 1
}

is_set() {
  if [ -z "$1" ]; then
    err "You must have your HOME environmental variable set to continue."
  fi
}

is_installed() {
  let ret='0'
  command -v $1 >/dev/null 2>&1 || { local ret='1'; }

  if [ "$ret" -ne 0 ]; then
    err "You must have '$1' installed to continue."
  fi
}

do_backup() {
  if [ -e "$1" ] || [ -e "$2" ] || [ -e "$3" ]; then
    msg "Attempting to backup your original vim configuration."
    today=`date +%Y%m%d_%s`
    for i in "$1" "$2" "$3"; do
      [ -e "$i" ] && [ ! -L "$i" ] && mv -v "$i" "$i.$today";
    done
    ret="$?"
    ok "Your original vim configuration hasbeen backed up."
  fi
}

########################################## MAIN()
is_set "$HOME"
is_installed "vim"
is_installed "git"

do_backup  "$HOME/.vim" \
	   "$HOME/.vimrc" \
	   "$HOME/.gvimrc"


