####### KOLORY
c_white="\[\e[37m\]"
c_celadon="\[\e[36m\]"
c_yellow="\[\e[33m\]"
c_green="\[\e[32m\]"
c_violet="\[\e[34m\]"
c_red="\[\e[31m\]"
c_reset="\[\e[0m\]"

PROMPT_COMMAND='export PS1="$c_celadon \u@bodhi $c_white`basename "$PWD"`$c_red \$ $c_reset"'
