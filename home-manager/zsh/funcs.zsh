path() {
    realpath "$(which "$@")"
}

contaminate() {
    if [[ -f "$1" ]]; then
        print "Contaminating" "$1"
        mv "$1" "$1.pure"
        install -m 644 "$1.pure" "$1"

        print "Editing" "$1"
        "$EDITOR" -- "$1"

        print "Decontaminating" "$1"
        mv "$1.pure" "$1"
    else
        print "$1" "does not exist!"
    fi
}

yazi() {
    local tmp="$(mktemp)"
    command yazi "$@" --cwd-file="$tmp"
    local cwd="$(cat "$tmp")"
    [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
}

xv() {
    [[ -z "$1" ]] && return
    if [[ -f "$1" ]]; then
        chmod +x "$1"
    else
        install /dev/null "$1"
    fi
    nvim "$1"
}

..() {
    if [[ -z "$1" ]]; then
        cd ..
    else
        cd $(awk "BEGIN {while (c++<$1) printf \"../\"}")
    fi
}

mkcd() {
    [[ -d "$1" ]] || mkdir -p "$1"
    cd "$1"
}

copypath() {
    if [[ -n "$1" ]]; then
        value="$(realpath -s "$1")"
        print "Copying" "$value"
        wl-copy <<<"$value"
    else
        print "Copying" "$PWD"
        pwd | wl-copy
    fi
}

copyfile() {
    if [[ -f "$1" ]]; then
        print "Copying the contents of" "$1"
        cat "$1" | wl-copy
    else
        print "$1" "not found"
    fi
}

notify-exit() {
    "$@"
    notify-send 
}

# clone a git repo and enter it
gc() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

### gh cli stuff
checkoutpr() {
  gh pr list | fzf --ansi --preview 'gh pr view {1}' --preview-window down --header-lines 3 | cut -d\  -f1 | xargs gh pr checkout
}

myprs(){
  gh search prs --author @me --state open | fzf --ansi --preview 'gh pr view --repo {1} {2}' --preview-window=80%:down --header-lines 4 | sed -nE "s@[^#]*#([0-9]*).*@\1@p"
}

# quickly access any alias or function i have
qa() {
  eval $( (alias && functions | sed -nE 's@^([^_].*)\(\).*@\1@p') | cut -d"=" -f1 | fzf --reverse)
}

# get cheat sheet for a command
chst() {
  [ -z "$*" ] && printf "Enter a command name: " && read -r cmd || cmd=$*
  curl -s cheat.sh/$cmd|bat --style=plain
}
