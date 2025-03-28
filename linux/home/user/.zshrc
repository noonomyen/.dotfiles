export ZSH="$HOME/.oh-my-zsh"

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

source $ZSH/oh-my-zsh.sh

# stty -a
bindkey '^H' backward-kill-word

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

bindkey -M emacs '^[[1;5A' history-substring-search-up
bindkey -M emacs '^[[1;5B' history-substring-search-down

[ -s "/home/noonomyen/.bun/_bun" ] && source "/home/noonomyen/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

eval "$(zoxide init zsh)"
alias cd=z

alias l="exa -lah --group-directories-first --git --icons --time-style=long-iso --color=always"
alias ls="exa --group-directories-first --git --icons --time-style=long-iso --color=always"

