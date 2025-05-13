# Set the file to save the history
HISTFILE=~/.zsh_history

# Set the number of commands to remember in the history file
HISTSIZE=10000

# Set the number of commands to keep in the history list in memory
SAVEHIST=10000

# Append to the history file instead of overwriting it
setopt APPEND_HISTORY

# Share history across all sessions
setopt SHARE_HISTORY


# Control
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char
bindkey '^[[1;6D' beginning-of-line
bindkey '^[[1;6C' end-of-line
bindkey '^[[3;5~' kill-word
bindkey '^H' backward-kill-word

# Exa
alias e='exa --icons -l'
alias ex='exa --icons'

# ls
alias l='e'
alias la='e -a'
alias ls="ex"
alias lsa='ex -a'
alias lsd='ex -T'
alias lsda='ex -T -a'

# zoxide
eval "$(zoxide init zsh)"
alias cd="z"
alias cdd='cd "$(zoxide query --interactive)"'

# vim
alias nvim="sudo -E nvim"
alias vim="nvim"
alias v="vim"

# Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.config/hypr/ohmyposh/theme.toml)"

# Configs
alias cdhy='cd ~/.config/hypr/'
alias cdua='cd /usr/share/applications'
alias cdla='cd ~/.local/share/applications'
alias dev='cd /data/development/'
alias c='clear'


export PATH=$PATH:/home/lunix/.spicetify
echo "\n"
neofetch
#if [ "$TMUX" = "" ]; then tmux; fi


# Created by `pipx` on 2024-08-28 17:03:53
export PATH="$PATH:/home/lunix/.local/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$JAVA_HOME/bin:$PATH
