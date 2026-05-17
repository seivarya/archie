
# ~/.bashrc
#

# if not running interactively, don't do anything

[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

alias pac='sudo pacman'
alias pacu='sudo pacman -Syu'
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias search='pacman -Ss'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq); sudo pacman -Sc'

alias mkd='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep='grep --color=auto'

alias cl='clear'
alias ff='fastfetch'
alias win='hyprctl clients'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias grep='grep --color=auto -n'
alias nv='nvim'

alias ..='cd ..'
alias ...='cd ../..'

alias venv='python3 -m venv .venv && source .venv/bin/activate'
