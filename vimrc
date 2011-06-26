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
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-cucumber'
Bundle 'altercation/vim-colors-solarized'
Bundle 'sethbc/fuzzyfinder_textmate'
Bundle 'Ack'

" OPTIONZZZ
syntax enable
set t_Co=16
set background=dark
colorscheme solarized

" fuzzy finder
map <leader>t :FuzzyFinderTextMate<CR>

filetype plugin indent on     " required! 
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
