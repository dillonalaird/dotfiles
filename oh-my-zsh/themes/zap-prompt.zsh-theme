#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git 


precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
precmd_functions+=( precmd_conda_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# gets too slow for large github repos
# +vi-git-untracked(){
#     if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#         git status --porcelain | grep '??' &> /dev/null ; then
#         hook_com[staged]+='!' # signify new files with a bang
#     fi
# }


# zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats " %{$fg[blue]%}[%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%}]%{$reset_color%}"

# I put this on my remote servers to show when I'm working on a remote server
# PROMPT="%{$fg[green]%}󰒋 "
PROMPT='%{$fg[green]%}${PIXI_PROJECT_NAME:+[$PIXI_PROJECT_NAME] }'
PROMPT+="%B%{$fg[yellow]%}% %(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$fg[cyan]%}%c%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "
