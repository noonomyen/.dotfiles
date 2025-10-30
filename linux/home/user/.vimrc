" Basic editor options
set mouse=a
set number
set encoding=utf-8
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set belloff=all

" Ctrl+Up/Down: move 4 lines
nnoremap <silent> <C-Up> 4k
nnoremap <silent> <C-Down> 4j
vnoremap <silent> <C-Up> 4k
vnoremap <silent> <C-Down> 4j
inoremap <silent> <C-Up> <C-o>4k
inoremap <silent> <C-Down> <C-o>4j

" Ctrl+Left/Right: word motions
nnoremap <silent> <C-Left> b
nnoremap <silent> <C-Right> w
vnoremap <silent> <C-Left> b
vnoremap <silent> <C-Right> w

" Ctrl+Backspace in insert mode
inoremap <silent> <C-BS> <C-w>
inoremap <silent> <C-h> <C-w>

" Ctrl+Shift+Left/Right: select word
nnoremap <silent> <C-S-Left> vB
nnoremap <silent> <C-S-Right> vE

" Ctrl+Shift+Up/Down: select 4 lines
nnoremap <silent> <C-S-Up> V4k
nnoremap <silent> <C-S-Down> V4j
vnoremap <silent> <C-S-Up> 4k
vnoremap <silent> <C-S-Down> 4j
inoremap <silent> <C-S-Up> <Esc>V4k
inoremap <silent> <C-S-Down> <Esc>V4j

" Ctrl+Alt+Left/Right = Begin/End of line
nnoremap <silent> <C-A-Left> ^
nnoremap <silent> <C-A-Right> $
vnoremap <silent> <C-A-Left> ^
vnoremap <silent> <C-A-Right> $
inoremap <silent> <C-A-Left> <C-o>^
inoremap <silent> <C-A-Right> <C-o>$

" Clear search highlight AND wipe last search register
nnoremap <silent> \\ :nohlsearch<Bar>let @/ = ""<CR>

" Send only yank (not delete) to clipboard
augroup ClipYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('/mnt/c/Windows/System32/clip.exe', @0) | endif
augroup END
