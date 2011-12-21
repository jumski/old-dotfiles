
Bundle 'wincent/Command-T'

Bundle 'tpope/vim-rails' 
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'php.vim'


Bundle 'tpope/vim-endwise'
Bundle 'delimitMate.vim'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/ack.vim'
Bundle 'ctags.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'matchit.zip'
Bundle 'repeat.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'othree/html5.vim'
Bundle 'samsonw/vim-task'
Bundle 'vimwiki'
Bundle 'TTCoach'
" Bundle 'autotags' " bug during BundleInstall
Bundle 'kchmck/vim-coffee-script'
" Bundle 'vim-fakeclip' " bug during BundleInstall
Bundle 'vim-scripts/marvim'

" PLUGIN OPTIONS AND MAPPINGS
runtime macros/matchit.vim
let g:CommandTMaxHeight=10
" autocmd BufWritePost *.coffee silent CoffeeMake! -b | cwindow " auto compiles coffee to js
