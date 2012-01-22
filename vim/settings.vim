
" default file encoding
set fileencodings=utf-8,latin2
set encoding=utf-8

" intuitive backspacing in insert mode
set backspace=indent,eol,start

" maintain long history
set history=5000

" set swap files dirs
set noswapfile
set nowritebackup

" set tags file location
set tags=TAGS;~/

" use horizontal line at cursor position
set cursorline

" line numbering
set number

" always show status line
set laststatus=2

" automatically read file if it changes
" this does not happen if file is deleted
set autoread

" display incomplete commands
set showcmd

" display the mode you're in
set showmode

" file type highlighting and configuration
syntax enable
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on


" set number of colors
set t_Co=256

" use dark background
set background=dark

" use solarized scheme
colorscheme solarized

" do not redraw while executing macros etc
set lazyredraw

" force syntax highlighting on files w/o extensions
au BufNewFile,BufRead Rakefile,Capfile,Guardfile,Gemfile,pryrc setfiletype ruby

" change behaviour of <TAB> completion of commands
" to similar to bash completion
set wildmenu
set wildmode=list:longest,list:full

" command history window height
set cmdwinheight=10

" indicates a fast terminal connection
" more characters will be sent to the screen for redrawing
set ttyfast

" removes the delay after returning to normal mode
set noesckeys

" time out on mapping after three seconds
" time out on key codes after a tenth of a second
set timeoutlen=3000
set ttimeoutlen=100

" add char pairs that can be navigated with %
set matchpairs+=<:>
set matchpairs+=/:/

" in ruby ? and : can be a part of keyword
set iskeyword+=?
set iskeyword+=!

"================ TABS AND SPACES
set expandtab     " all tabs expands to spaces
set sw=2          " automagic indent width
set tabstop=2     " size of tab in spaces
set ts=2          " size of tab
set shiftround    " round indent to multiple of 'shiftwidth', applies to > and <
set softtabstop=2 " number of spaces that a <Tab> counts for
                  " while performing editing operations

" new splits always bo to the right
" " or below current window
set splitbelow
set splitright

" 1. The current buffer can be put to the background without writing to disk
" 2. When a background buffer becomes current again, marks and
"    undo-history are remembered
set hidden

" show results during typing the search
set incsearch

" search will be case sensitive only when
" capital letter is present
set ignorecase
set smartcase

" maintain context around the cursor
" when scrolling near the edge of screen
set scrolloff=3

" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" session saving options
set sessionoptions=buffers,winsize,tabpages,winpos,winsize

" automatically strip whitespaces
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let _s=@/
  call cursor(l, c)
  let @/=_s
endfun
autocmd BufWritePre *.* :call <SID>StripTrailingWhitespaces()

" Restore cursor position
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" {{{
" {{{ SESSION AUTOSAVE
" {{{ TODO: rewrite for my usage
fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction
fu! RestoreSess()
if filereadable(getcwd() . '/.session.vim')
  execute 'source ' . getcwd() . '/.session.vim'
  "if bufexists(1)
  "  for l in range(1, bufnr('$'))
  "    if bufnr(l) == -1
  "      exec 'sbuffer ' . l
  "    endif
  "  endfor
  "endif
endif
syntax enable
endfunction
" autocmd VimLeave * call SaveSess()
"autocmd VimEnter * call RestoreSess()
" }}}
" }}} SESSION AUTOSAVE
" }}}





" shorten 'Press ENTER or type command to continue' messages
" TODO: ENABLE THIS AFTER SOME LEARNING
" set shortmess=atI

" remember some stuff after quiting vim:
" marks, registers, searches, buffer list
" TODO: some error happens here
" set viminfo='100,<50,s10,h,%>
