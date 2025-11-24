ZSH_THEME="agnoster"

plugins=(
    history
    git
    docker
    web-search
    copypath
    copybuffer
    dirhistory
    jsontools
    zsh-history-substring-search
    fzf

    shellfirm
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-shift-select
)

export ZSH="$HOME/.oh-my-zsh"
export NVM_DIR="$HOME/.nvm"
export BUN_INSTALL="$HOME/.bun"
export PATH="$HOME/.local/bin:$BUN_INSTALL/bin:$PATH"

source "$NVM_DIR/nvm.sh"
source "$NVM_DIR/bash_completion"
source "$HOME/.bun/_bun"
source "$HOME/.cargo/env"
source "$ZSH/oh-my-zsh.sh"

# stty -a
bindkey '^H' backward-kill-word
bindkey -M emacs '^[[1;5A' history-substring-search-up
bindkey -M emacs '^[[1;5B' history-substring-search-down

unsetopt BEEP

setopt KSH_GLOB
setopt SHARE_HISTORY

zsh_hide_path() {
    prompt_dir() {
        prompt_segment blue black '%c'
    }
}

zsh_unhide_path() {
    prompt_dir() {
        prompt_segment blue black '%~'
    }
}

eval "$(zoxide init zsh)"

alias cd=z
alias l="eza -alghHiMnOSmU --group-directories-first --git --icons --time-style=long-iso --color=always"
alias ls="eza --group-directories-first --git --icons --time-style=long-iso --color=always"

