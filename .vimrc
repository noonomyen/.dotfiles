" https://github.com/VundleVim/Vundle.vim
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

syntax on
set encoding=utf-8
set mouse=a
set number
set smartindent
set title

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
if system('uname -r') =~ "microsoft"
    augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
    augroup END
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
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" https://github.com/preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

