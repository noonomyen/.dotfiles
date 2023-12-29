set shell=/usr/bin/bash

" https://github.com/VundleVim/Vundle.vim
set encoding=utf-8
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'joshdick/onedark.vim'
    Plugin 'sheerun/vim-polyglot'
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'Yggdroot/indentLine'
    Plugin 'ycm-core/YouCompleteMe'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'preservim/nerdtree'
    Plugin 'tpope/vim-fugitive'
    Plugin 'airblade/vim-gitgutter'
    Plugin 'mg979/vim-visual-multi'
    Plugin 'editorconfig/editorconfig-vim'
    Plugin 'wakatime/vim-wakatime'
    Plugin 'junegunn/fzf',
    Plugin 'junegunn/fzf.vim',
    Plugin 'dense-analysis/ale'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'
call vundle#end()
filetype plugin indent on

syntax on
set encoding=utf-8
set mouse=a
set number
set smartindent
set title

let NERDTreeShowHidden=1

" https://www.wiserfirst.com/blog/vim-tip-snipmate-legacy-parser-warning
let g:snipMate = { 'snippet_version' : 1 }

" https://www.cyberciti.biz/faq/vim-vi-text-editor-save-file-without-root-permission
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

" https://github.com/microsoft/WSL/issues/4440
let WindowsClipboardCommandExe = '/mnt/c/Windows/System32/clip.exe'

if executable(WindowsClipboardCommandExe)
    augroup WSLYank
    autocmd!
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system(WindowsClipboardCommandExe, @0) | endif
    augroup END
endif

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
nnoremap <C-\> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" https://github.com/vim-airline/vim-airline
let g:airline#extensions#tabline#enabled = 1

" https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
noremap! <C-BS> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db
noremap! <C-h> <C-w>
" noremap! <C-?> <C-w>

" https://vi.stackexchange.com/a/24396
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" https://github.com/ycm-core/YouCompleteMe/issues/2015#issuecomment-189917191
set completeopt-=preview

" https://superuser.com/a/884981
nnoremap <C-S-Left> :tabprevious<CR>
nnoremap <C-S-Right> :tabnext<CR>

" https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
let g:VM_maps = {}
let g:VM_default_mappings = 0
let g:VM_maps["Add Cursor Down"] = '<M-Down>'
let g:VM_maps["Add Cursor Up"] = '<M-Up>'
let g:VM_maps['Find Under'] = '<>'
let g:VM_maps['Find Subword Under'] = '<>'

inoremap <C-Up> <Esc>4ki
nnoremap <C-Up> <Esc>4k
inoremap <C-Down> <Esc>4ji
nnoremap <C-Down> <Esc>4j

" https://superuser.com/a/634327
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" https://stackoverflow.com/a/11560415
set backspace=indent,eol,start

" https://vi.stackexchange.com/a/4655
set belloff=all

command! -nargs=0 FFDos :set fileformat=dos
command! -nargs=0 FFUnix :set fileformat=unix
