source ~/.zplug/init.zsh

zplug "chitoku-k/fzf-zsh-completions"

zplug load

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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
    # you-should-use
    zsh-autosuggestions
    zsh-syntax-highlighting
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

# bun completions
# [ -s "/home/user/.bun/_bun" ] && source "/home/user/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# https://github.com/nvbn/thefuck
# eval $(thefuck --alias --enable-experimental-instant-mode)

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

