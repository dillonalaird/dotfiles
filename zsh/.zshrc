# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="zap-prompt"
plugins=(git fzf-tab zsh-autosuggestions zsh-syntax-highlighting zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# zsh, default on macOS - load pixi completions after Oh My Zsh
fpath+=(~/.pixi/completions/zsh)
autoload -Uz compinit
compinit

unalias ls
alias ls="lsd --group-dirs first"
alias vim=nvim
alias tmux="tmux new-session -A -s dev"
# alias icat="kitten icat"
alias icat="wezterm imgcat"

export PATH="$HOME/.local/bin:$PATH"
. "$HOME/.local/bin/env"
export PATH="/Users/dillonlaird/.pixi/bin:$PATH"
