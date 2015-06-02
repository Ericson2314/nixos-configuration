shopt -s histappend
shopt -s cmdhist

source $HOME/.environment

HISTTIMEFORMAT='%F %T '
HISTCONTROL=ignoreboth
HISTTIMEFORMAT='%s'
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.bash_history


PROMPT_COMMAND='history -a'
