set guicursor = ""
set scrolloff=8
set number
set relativenumber
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" maybe next one is bad
set autoindent
set wrap!
set swapfile!
set backup!
set hlsearch!
set incsearch
set signcolumn="yes"
set colorcolumn="79"

set foldmethod=indent
set foldlevel=99
colorscheme desert


let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-k> :cnext<CR>
nnoremap <C-j> :cprev<CR>
nnoremap <C-E> :copen<CR>

" remaps
nnoremap <C-d> <C-d>zz)
nnoremap <C-u> <C-u>zz)

" registers
xnoremap <leader>p "_dP
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <leader>gl :! git l<CR>

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
