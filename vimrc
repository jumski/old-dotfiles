set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-rails' 
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-endwise'
Bundle 'delimitMate.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/ack.vim'
Bundle 'vim-ruby/vim-ruby'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ctags.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'matchit.zip'
Bundle 'repeat.vim'
Bundle 'tomtom/tcomment_vim'

filetype plugin indent on
filetype plugin on

"""""""""" CUSTOM OPTIONS

set number
set directory=/tmp
set sessionoptions=buffers,folds,winsize,winpos
set encoding=utf-8                " Default encoding
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.
set tags=~/tags

" Syntax highlighting and eyecandy
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

" force syntax highlighting on files w/o extensions
au BufNewFile,BufRead Rakefile setfiletype ruby
au BufNewFile,BufRead Capfile setfiletype ruby
au BufNewFile,BufRead Guardfile setfiletype ruby
au BufNewFile,BufRead Gemfile setfiletype ruby

" PLUGIN OPTIONS AND MAPPINGS
runtime macros/matchit.vim
let g:CommandTMaxHeight=10

""""" CUSTOM MAPPINGS
noremap <leader>` :CommandT<cr>

" touch current file (useful for triggering guard)
" noremap <silent><leader>r :call system('touch ' . expand("%:p"))<cr> 

