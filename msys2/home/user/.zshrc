export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster-custom"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
)

source $ZSH/oh-my-zsh.sh

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
