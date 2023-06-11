set shell=/usr/bin/bash

source ~/.dotfiles/universal/vim/.vimrc

" https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" https://github.com/microsoft/WSL/issues/4440
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
