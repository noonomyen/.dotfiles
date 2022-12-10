export ZSH="$HOME/.oh-my-zsh"

source /cbin/preload

ZSH_THEME="agnoster"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export COLORTERM=truecolor

unsetopt BEEP

bindkey '^H' backward-kill-word
wsl2_fastcd $PWD

