#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='flatpak run com.visualstudio.code' 
PS1='[\u@\h \W]\$ '
export VK_DRIVER_FILES=/usr/share/vulkan/icd.d/nvidia_icd.json
