"" General
syntax on
set exrc                            " Custom vimrcs
set relativenumber                  " Relative number
set number                          " Show line numbers

set noerrorbells                    " No error bell
set nohlsearch                      " Do not keep highlights

set nowrap                          " Wrap lines
set textwidth=80                    " Line wrap (number of cols)
set colorcolumn=80

set showmatch                       " Highlight matching brace
set visualbell                      " Use visual bell (no beeping)

set smartcase                       " Enable smart-case search
set ignorecase                      " Always case-insensitive
set incsearch                       " Searches for strings incrementally

set autoindent                      " Auto-indent new lines
set expandtab                       " Use spaces instead of tabs
set shiftwidth=4                    " Number of auto-indent spaces
set tabstop=4                       " Number of spaces per Tab
set softtabstop=4                   " Number of spaces per Tab
set smartindent                     " Intelligent indenting

"" Advanced
set scrolloff=8                     " Start scroll 8 lines before
set signcolumn=yes                  " Sign column on the left
set completeopt=menuone             " Menu when code completing
set completeopt=noinsert            " Do not auto insert when code completing
set completeopt=noselect            " Do not auto select when code completing

set undodir=~/.vim/undodir          " Where to keep the undofile
set undofile                        " Save undo history to a file
set noswapfile                      " Do not keep a swapfile
set hidden                          " Keep buffer when out of file
set nobackup                        " Do not keep a backup
set ruler                           " Show row and column ruler information

set undolevels=1000                 " Number of undo levels
set backspace=indent,eol,start	    " Backspace behaviour


call plug#begin()

Plug 'arcticicestudio/nord-vim'
Plug 'preservim/nerdtree'
Plug 'dmerejkowsky/vim-ale'

call plug#end()

" colorscheme nord

let g:ale_linters = {'bash': ["shellcheck"]}
let g:ale_linters = {'c': ["gcc"]}
let g:ale_linters = {'c++': ["g++"]}
let g:ale_linters = {'java': ["checkstyle"]}
let g:ale_linters = {'python': ["flake8"]}

let g:ale_fixers = {'bash': ["shellcheck"]}
let g:ale_fixers = {'c': ["gcc"]}
let g:ale_fixers = {'c++': ["gcc"]}
let g:ale_fixers = {'java': ["checkstyle"]}
let g:ale_fixers = {'python': ["black"]}

let g:ale_fix_on_save = 1

