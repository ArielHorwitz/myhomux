#! /usr/bin/bash

unalias -a

alias resource="source ~/.bashrc" # Reread .bashrc
alias c="clear"
alias xo="xdg-open"
alias cpi="cp -i"
alias tarz="tar -vzcf"
alias taru="tar -vkxf"
alias tarl="tar -tf"
alias rp="rhinopuffin"
alias gp="geckopanda"
alias oa="openassistant"
alias oam="openassistant -L0 | markdown"
alias or="openartist"

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias printenv='printenv | sort'

alias historylog="HISTTIMEFORMAT='%c ' history | bat"
alias watcha="watch "

# Python
alias pyactivate="source venv/bin/activate"
alias pipr="pip install -r requirements.txt"
alias py="python main.py"

# Rust
alias cr="cargo run --"
alias crb="cargo run --bin"
alias crq="cargo run -q --"
alias crf="cargo fmt; cargo run -q --"
alias rustbt_on="export RUST_BACKTRACE=1"
alias rustbt_off="export RUST_BACKTRACE=0"
alias rustbt_full="export RUST_BACKTRACE=full"
alias bacongood="bacon clippy -- --"\
" --warn clippy::panic"\
" --warn clippy::unwrap_used"\
" --warn clippy::unwrap_in_result"
alias baconbetter="bacon clippy -- -- --warn clippy::pedantic"
alias crr="cargo release --no-publish"

# SSH
alias "ssh-keygen"="ssh-keygen -t ed25519"

# Docker
alias dkdaemon="sudo systemctl start docker"
alias dklast="docker ps -la"
alias dkall="docker images -a && echo && docker ps -a"
dkbash() {
    docker container exec -i $(docker ps -lq) /bin/bash
}
dkkill() {
    docker kill $(docker ps -lq)
}

# Miscallaneous
view-source() {
    bat $(which $@)
}

set-wallpaper() {
    sudo cp -f $1 /usr/share/backgrounds/desktop.png
    feh --bg-fill --no-xinerama '/usr/share/backgrounds/desktop.png'
}

set-lockscreen() {
    sudo cp -f $1 /usr/share/backgrounds/lockscreen.png
}

blog() {
    bat -l log $@
}

mkcd() {
    mkdir -p $1 && cd $1
}

cdre() {
    cd $PWD
}

cdl() {
    cd $1 && lsl
}

starttest() {
    mkcd /tmp/terminaltest-$RANDOM
    printcolor -s debug "New test directory."
}
