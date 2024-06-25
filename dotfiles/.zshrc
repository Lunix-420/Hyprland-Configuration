export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="archcraft"
zstyle ':omz:update' mode disabled  # disable automatic updates
plugins=(git)
source $ZSH/oh-my-zsh.sh

# On-demand rehash
zshcache_time="$(date +%s%N)"
autoload -Uz add-zsh-hook
rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}
add-zsh-hook -Uz precmd rehash_precmd

# omz
alias zshconfig="geany ~/.zshrc"
alias ohmyzsh="thunar ~/.oh-my-zsh"

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

# vim
alias vim="nvim"
alias svim="sudo -E nvim"

# Oh-My-Posh
eval "$(oh-my-posh init zsh --config ~/.config/hypr/ohmyposh/theme.toml)"

# Configs
alias cdhy='cd ~/.config/hypr/'


export PATH=$PATH:/home/lunix/.spicetify
