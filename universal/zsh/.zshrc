export ZSH="$HOME/.oh-my-zsh"
export COLORTERM=truecolor

ZSH_THEME="agnoster"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    docker
)

source $ZSH/oh-my-zsh.sh

# stty -a
if [[ $REMOTE_FROM == "windows" ]]; then
    bindkey '^H' backward-kill-word
fi

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
