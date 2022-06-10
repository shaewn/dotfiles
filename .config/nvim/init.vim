set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set exrc
set guicursor=
set nohlsearch
set noerrorbells
set nu
set relativenumber
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set showmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set cmdheight=2
set updatetime=40
set shortmess+=c
set cino=l1

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-surround'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'embark-theme/vim', { 'as': 'embark', 'branch': 'main' }
Plug 'deathlyfrantic/vim-distinguished'
Plug 'mattn/emmet-vim'
Plug 'mxw/vim-jsx'
Plug 'vim-autoformat/vim-autoformat'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'shmup/vim-sql-syntax'
Plug 'rust-lang/rust.vim'
Plug 'arzg/vim-rust-syntax-ext'
call plug#end()

let mapleader = " "
nnoremap <silent> <leader>ff :Autoformat<CR>
nnoremap <C-P> :Files<CR>
nnoremap <leader>bs :Buffers<CR>
nnoremap <leader>bn :bn<CR>
nnoremap <leadeR>bp :bp<CR>

execute "set t_8f=\e[38;2;%lu;%lu;%lum"
execute "set t_8b=\e[48;2;%lu;%lu;%lum"

set termguicolors

colorscheme embark

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup SEM
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

