Bundle 'altercation/vim-colors-solarized'
Bundle 'delimitMate.vim'
" Bundle 'gmarik/ide-popup.vim'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-fakeclip'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lastpos.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'matchit.zip'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'repeat.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/ack.vim'
Bundle 'vim-scripts/file-line'
Bundle 'ZoomWin'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'sjl/gundo.vim'
Bundle 'jumski/ultisnips'
Bundle 'duskhacker/sweet-rspec-vim'
Bundle 'kien/ctrlp.vim'

""""""""" DISABLED PLUGINS
" Bundle 'php.vim'
" Bundle 'samsonw/vim-task'
" Bundle 'tpope/vim-cucumber'
" Bundle 'TTCoach' " touch typing coach
" Bundle 'vim-scripts/marvim' " macro persistent storage
" Bundle 'vimwiki'
" Bundle 'wincent/Command-T' " textmate-like searching throught project

"===============================
"    plugin specific options
"===============================

" map <leader>xf :SweetVimRspecRunFile<CR>
" map <leader>xs :SweetVimRspecRunFocused<CR>
" map <leader>xp :SweetVimRspecRunPrevious<CR>

map <leader>b :CtrlPBuffer<CR>

" set leader for easy motion
let g:EasyMotion_Leader_key = ',,'

" set commant-t window height
let g:CommandTMaxHeight=10

" require matchit manually
runtime macros/matchit.vim

" redefine Rjavascripts
autocmd User Rails Rnavcommand javascripts app/assets/javascripts/ -suffix=.js,.js.erb,.js.coffee,.js.coffee.erb

" define Rsupport
autocmd User Rails Rnavcommand support spec/support/ -suffix=.rb

" define Ruploaders
autocmd User Rails Rnavcommand uploaders app/uploaders/ -suffix=.rb

" define Roverrides
autocmd User Rails Rnavcommand overrides app/overrides/ -suffix=.rb

" define Rfactories
autocmd User Rails Rnavcommand factories spec/factories/ -suffix=.rb
