#=======================================================================================
# History Settings
#=======================================================================================

# Set the file to save the command history
HISTFILE=~/.zsh_history

# Set the number of commands to remember in memory and save to file
HISTSIZE=10000        # Number of history entries to keep in memory
SAVEHIST=10000        # Number of history entries to save to file

# History options for better session handling
setopt APPEND_HISTORY    # Append new commands to the history file (don't overwrite it)
setopt SHARE_HISTORY     # Share command history across all ZSH sessions

#=======================================================================================
# Key Bindings
#=======================================================================================

# Custom keybindings for improved CLI navigation

bindkey "^[[1;5C" forward-word         # Ctrl + Right Arrow → move forward by word
bindkey "^[[1;5D" backward-word        # Ctrl + Left Arrow → move backward by word
bindkey "^[[3~" delete-char            # Delete key → delete character under cursor
bindkey '^[[1;6D' beginning-of-line    # Ctrl + Shift + Left → move to beginning of line
bindkey '^[[1;6C' end-of-line          # Ctrl + Shift + Right → move to end of line
bindkey '^[[3;5~' kill-word            # Ctrl + Delete → delete word after cursor
bindkey '^H' backward-kill-word        # Ctrl + Backspace → delete word before cursor

#=======================================================================================
# Aliases
#=======================================================================================

#----- Exa (ls replacement with icons) -----
alias e='exa --icons -l'          # Long list with icons
alias ex='exa --icons'            # Basic list with icons
alias l='e'                       # Alias for long list
alias la='e -a'                   # Show hidden files with long list
alias ls='ex'                     # Replace ls with exa
alias lsa='ex -a'                 # Replace ls -a
alias lsd='ex -T'                 # Tree view
alias lsda='ex -T -a'             # Tree view including hidden files

#----- Vim / Neovim -----
alias nvim='sudo -E nvim'         # Run nvim with sudo and preserve env
alias vim='nvim'                  # Alias vim to nvim
alias v='vim'                     # Short alias

#----- Quick directory jumps -----
alias cdhy='cd ~/.config/hypr/'                  # Jump to Hyprland config dir
alias cdua='cd /usr/share/applications'          # Jump to system .desktop files
alias cdla='cd ~/.local/share/applications'      # Jump to user .desktop files
alias dev='cd /data/development/'                # Jump to dev folder
alias dmt='cd /data/development/dimethoxy/'      # Jump to Dimethoxy repo

#----- Miscellaneous -----
alias c='clear'                      # Clear terminal
alias cat='bat --paging=never'       # Replace cat with bat for syntax highlighting (static file)
alias ccc="| wl-copy"
#=======================================================================================
# Plugins
#=======================================================================================

#----- zoxide (smarter cd replacement) -----
eval "$(zoxide init zsh)"       # Initialize zoxide
alias cd='z'                    # Replace cd with z (smarter navigation)
alias cdd='cd "$(zoxide query --interactive)"'  # Interactive jump

#----- Oh My Posh (fancy prompt) -----
eval "$(oh-my-posh init zsh --config ~/.config/hypr/ohmyposh/theme.toml)"  # Load theme

#----- Syntax highlighting -----
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # Enable syntax colors

#----- Autosuggestions -----
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh  # Enable suggestions as you type

#----- fzf (fuzzy finder) -----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh   # Load fzf if installed

#----- thefuck (corrects previous commands) -----
eval $(thefuck --alias FUCK)  # Alias with all caps for fun
eval $(thefuck --alias)       # Default alias: `fuck`

#=======================================================================================
# PATH Settings
#=======================================================================================

# Extend PATH with common custom locations

export PATH="$PATH:/home/lunix/.spicetify"     # Spicetify CLI
export PATH="$PATH:/home/lunix/.local/bin"     # User local binaries
export PATH="$HOME/.cargo/bin:$PATH"           # Rust cargo binaries
export PATH="$JAVA_HOME/bin:$PATH"             # Java binaries (requires JAVA_HOME set)

#=======================================================================================
# Final Touch / Misc
#=======================================================================================

#----- Display system info on terminal start -----
echo "\n"            # Add some spacing before output
neofetch             # Show system info with Neofetch

