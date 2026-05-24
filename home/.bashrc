#
# ~/.bashrc
#

# [ interactive shell check ]

source /usr/share/git-core/git-prompt.sh
fastfetch

[[ $- != *i* ]] && return

# [ prompt ]

PS1="\[\e[38;2;230;230;230m\][ \[\e[38;2;217;217;217m\]\u \[\e[38;2;191;191;191m\]:: \[\e[38;2;204;204;204m\]\w\[\e[38;2;191;191;191m\]\$(__git_ps1) \[\e[38;2;230;230;230m\]] \[\e[38;2;230;230;230m\]> \[\e[0m\]"

# [ package management ]

alias pac='sudo pacman'
alias pacu='sudo pacman -Syu'
alias paci='sudo pacman -S'
alias pacr='sudo pacman -Rns'
alias search='pacman -Ss'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq); sudo pacman -Sc'

# [ file operations ]

alias mkd='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias grep='grep --color=auto -n'

# [ shortcuts ]

alias cl='clear'
alias ff='fastfetch'
alias win='hyprctl clients'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias nv='nvim'

# [ navigation ]

alias ..='cd ..'
alias ...='cd ../..'

# [ python virtual environment ]

alias venv='python3 -m venv .venv && source .venv/bin/activate'

