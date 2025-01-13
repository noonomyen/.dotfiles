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

alias ls=eza

# bun completions
[ -s "/home/noonomyen/.bun/_bun" ] && source "/home/noonomyen/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
