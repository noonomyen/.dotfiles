" https://github.com/VundleVim/Vundle.vim
set encoding=utf-8
set shell=/bin/bash
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'sheerun/vim-polyglot'
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'Yggdroot/indentLine'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'preservim/nerdtree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
call vundle#end()
filetype plugin indent on

let WSL2_SUPPORT = 1
" if system('uname -r') =~ "Microsoft"
"     if $vim_disable_wsl2_support != "true"
"         let WSL2_SUPPORT = 1
"     endif
" endif

syntax on
set encoding=utf-8
set mouse=a
set number
set smartindent
set title

" https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

command Wq :execute ':silent w !sudo tee % > /dev/null' | :q

" https://vim.fandom.com/wiki/Disable_beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting
set hlsearch
nnoremap <leader>\ :noh<CR>

" https://linuxhandbook.com/vim-indentation-tab-spaces/
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4

" https://waylonwalker.com/vim-wsl-clipboard/#wsl2
"if WSL2_SUPPORT
"    augroup Yank
"        autocmd!
"        autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
"    augroup END
"endif

if WSL2_SUPPORT
    " https://github.com/microsoft/WSL/issues/4440
    let s:clip = '/mnt/c/Windows/System32/clip.exe' " change this path according to your mount point
    if executable(s:clip)
        augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
        augroup END
    endif
endif

" https://github.com/joshdick/onedark.vim
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif
colorscheme onedark
let g:lightline = { 'colorscheme': 'onedark' }

" https://github.com/Yggdroot/indentLine
" :IndentLinesToggle toggles lines on and off.
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" https://github.com/preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

