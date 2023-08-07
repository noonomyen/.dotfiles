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
bindkey '^H' backward-kill-word
# bindkey '^?' backward-kill-word

unsetopt BEEP

setopt KSH_GLOB
setopt SHARE_HISTORY

