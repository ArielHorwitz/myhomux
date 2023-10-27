#! /usr/bin/bash
#
# ~/.bashrc
#

# SSH
alias keygen="ssh-keygen -t ed25519 -C 'ariel.ninja' && cat ~/.ssh/id_ed25519.pub"
alias sshadd="eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519.pub"
# Git aliases
alias gitlive="dointerval 2 'git overview'"

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

# Python
alias pyvenv="python -m venv venv && pyactivate"
alias pyactivate="source venv/bin/activate"
alias pipi="pip install --upgrade pip && [[ -f requirements.txt ]] && pip install -r requirements.txt"
alias py="python main.py"
alias pyflint="black --fast .; isort --profile black -l 88 .; flake8 --max-line-length 88 ."
alias pytest="python -m unittest discover -v -s tests -t ."
alias pytestf="python -m unittest discover -v -f -s tests -t ."

# Rust
alias crun="cargo run --"
alias crunq="cargo run -q --"
alias crunb="cargo run --bin"
alias cclip="cargo clippy --"
alias rustbt_on="export RUST_BACKTRACE=1"
alias rustbt_off="export RUST_BACKTRACE=0"
alias rustbt_full="export RUST_BACKTRACE=full"
alias baconm="bacon clippy -- --"\
" --warn clippy::panic"\
" --warn clippy::unwrap_used"\
" --warn clippy::unwrap_in_result"\
" --warn clippy::str_to_string"\
" --warn clippy::verbose_file_reads"\
" --warn clippy::indexing_slicing"\
""

# Django
alias djm="python manage.py"
alias djrun="djm runserver"
alias djboot="djm makemigrations && djm migrate && djm createsuperuser --username admin --email admin@ariel.ninja"
alias djnuke="
	if [ -f "manage.py" ] ; then
		python manage.py flush --noinput && sleep 1 && rm -rf ./media && djboot ;
	else
		echo 'Not in correct directory.' ;
	fi"

# Misc
alias i3windetails='xprop | grep -iE "wm_class|wm_window_role|wm_window_type|wm_name"'
alias resource="source ~/.bashrc" # Reread .bashrc
alias lxl="lite-xl"
alias less="bat"
alias lsl="ls -lsh --group-directories-first --color"
alias lsa="ls -lsha --group-directories-first --color"
alias lsr="ls -lshR --group-directories-first --color"

# ---------------------------------------------------------

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
# case ${TERM} in
# 	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
# 		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
# 		;;
# 	screen*)
# 		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
# 		;;
#     alacritty)
#         PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
#         ;;
# esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
