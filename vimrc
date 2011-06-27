set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" BUNDLEZZZ
Bundle 'tpope/vim-rails' 
Bundle 'tpope/vim-haml'
" auto closing / end
Bundle 'tpope/vim-endwise'
Bundle 'delimitMate.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/ack.vim'
"Bundle 'vim-scripts/minibufexplorer'
Bundle 'vim-ruby/vim-ruby'
Bundle 'altercation/vim-colors-solarized'
Bundle 'minibufexpl.vim'
Bundle 'ctags.vim'
Bundle 'Lokaltog/vim-easymotion'
" syntax error highlighting
Bundle 'Syntastic'
" better pair matching
Bundle 'matchit.zip'
" repeat commands from plugins by '.'
Bundle 'repeat.vim'
" OPTIONZZZ
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

set number
noremap <leader>qqq :MiniBufExplorer<cr>
noremap <leader>` :CommandT<cr>

set directory=/tmp

filetype plugin indent on     " required! 
filetype plugin on

runtime macros/matchit.vim        " Load the matchit plugin.

set encoding=utf-8                " Default encoding
set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.
set backspace=indent,eol,start    " Intuitive backspacing.

"
" Brief help
"
" :BundleInstall  - install bundles (won't update installed)
" :BundleInstall! - update if installed
"
" :Bundles foo    - search for foo
" :Bundles! foo   - refresh cached list and search for foo
"
" :BundleClean    - confirm removal of unused bundles
" :BundleClean!   - remove without confirmation
"
" see :h vundle for more details
" or wiki for FAQ
" Note: comments after Bundle command are not allowed..
