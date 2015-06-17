# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

# Load personal environment settings.
source $HOME/.environment

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

setopt HIST_IGNORE_ALL_DUPS # don't add multiple 'cd ..', etc in a row?
setopt HIST_IGNORE_SPACE    # initial space makes private
setopt HIST_EXPIRE_DUPS_FIRST # save unique hist entries longer
setopt HIST_VERIFY # edit recalled history before running
setopt SHARE_HISTORY # Reloads the history whenever you use it
setopt INC_APPEND_HISTORY # add commands to .history immediately
setopt EXTENDED_HISTORY # save timestamp on history entries

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
