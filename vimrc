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
Bundle 'othree/html5.vim'
Bundle 'php.vim'
Bundle 'samsonw/vim-task'
Bundle 'vimwiki'
Bundle 'TTCoach'
Bundle 'autotags'
Bundle 'kchmck/vim-coffee-script'
Bundle 'vim-fakeclip'

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
set tags=./tags
set cursorline

"""""""""" TABS and SPACES
set ts=2          " szerokosc tabulacji 
set sw=2          " szerokosc automagicznego wciecia
set expandtab     " rozwijanie tabow na spacje"
set tabstop=2     " ile spacji to tab"    
set softtabstop=2

" kodowanie
set fileencodings=utf-8,latin2

" Syntax highlighting and eyecandy
syntax enable
set t_Co=256
set background=dark
colorscheme solarized
set lazyredraw

" force syntax highlighting on files w/o extensions
au BufNewFile,BufRead Rakefile setfiletype ruby
au BufNewFile,BufRead Capfile setfiletype ruby
au BufNewFile,BufRead Guardfile setfiletype ruby
au BufNewFile,BufRead Gemfile setfiletype ruby

" PLUGIN OPTIONS AND MAPPINGS
runtime macros/matchit.vim
let g:CommandTMaxHeight=10
autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow " auto compiles coffee to js

""""" CUSTOM MAPPINGS
noremap <leader>` :CommandT<cr>
noremap <C-k><C-k> <C-w><C-w>
noremap <C-k>k <C-w><C-w>
imap <C-w> <C-o><C-w> " this allows all window commands in insert mode and i'm not accidentally deleting words anymore :-)"

" tab mappings
nmap <silent> <leader>n :tabnew %<CR>
nmap <silent> <leader><leader> :tabn<CR>
nmap <silent> <leader><Tab> :tabp<CR>
nmap <silent> <leader>c :tabclose<CR>
" nmap <silent> <C--> :tabp

" touch current file (useful for triggering guard)
" noremap <silent><leader>r :call system('touch ' . expand("%:p"))<cr> 

