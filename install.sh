#

############################  SETUP PARAMETERS
[ -z "$APP_PATH" ] && APP_PATH="$HOME/.chilic-vim"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/chilic/vim.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='main'

############################  BASIC SETUP TOOLS
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

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
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

sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"

    msg "Trying to update $repo_uri"

    if [ ! -e "$repo_path" ]; then
        msg "Cloning repo into $repo_path"
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        ok "Successfully cloned $repo_uri."
    else
        msg "Pulling updates into $repo_path"
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        ok "Successfully updated $repo_uri."
    fi
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.vimrc"         "$target_path/.vimrc"
    lnif "$source_path/.plugins.vimrc" "$target_path/.plugins.vimrc"
    lnif "$source_path/.vim"           "$target_path/.vim"

    if is_installed "nvim"; then
        lnif "$source_path/.vim"       "$target_path/.config/nvim"
        lnif "$source_path/.vimrc"     "$target_path/.config/nvim/init.vim"
    fi

    touch  "$target_path/.vimrc.local"

    ret="$?"
    ok "Setting up vim symlinks."
}

########################################## MAIN()
is_set "$HOME"
is_installed "vim"
is_installed "git"

do_backup   "$HOME/.vim" \
	        "$HOME/.vimrc" \
			"$HOME/.gvimrc"

sync_repo   "$APP_PATH" \
	        "$REPO_URI" \
	        "$REPO_BRANCH"

create_symlinks "$APP_PATH" \
                "$HOME"

msg             "\nThanks for installing chilic-vim."
msg             "© `date +%Y` https://hownotto.dev/"
