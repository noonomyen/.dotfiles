#!/bin/bash

echo "dotfiles updater ! (wsl2)"

if [[ $1 == "repo" ]]; then
    cp /usr/bin/wsl2_fastcd ./bin/wsl2_fastcd.sh
    cp ~/.vimrc .
    cp ~/.zshrc .
elif [[ $1 == "local" ]]; then
    cp ./bin/wsl2_fastcd.sh /usr/bin/wsl2_fastcd
    chmod 777 /usr/bin/wsl2_fastcd
    cp .vimrc ~/.vimrc
    chown $2 ~/.vimrc
    cp .zshrc ~/.zshrc
    chown $2 ~/.zshrc
fi

