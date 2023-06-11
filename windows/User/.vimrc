source ~\.dotfiles\universal\vim\.vimrc

" https://github.com/microsoft/WSL/issues/4440
let s:clip = 'C:\Windows\System32\clip.exe'
if executable(s:clip)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif
