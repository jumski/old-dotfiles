Bundle 'altercation/vim-colors-solarized'
Bundle 'delimitMate.vim'
" Bundle 'gmarik/ide-popup.vim'
Bundle 'godlygeek/tabular'
Bundle 'kana/vim-fakeclip'
Bundle 'kchmck/vim-coffee-script'
Bundle 'lastpos.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'jumski/Conque-Shell'
Bundle 'matchit.zip'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'repeat.vim'
Bundle 'scrooloose/syntastic'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rake'
Bundle 'vim-ruby/vim-ruby'
" Bundle 'vim-scripts/ack.vim'
Bundle 'epmatsw/ag.vim'
Bundle 'vim-scripts/file-line'
" Bundle 'ZoomWin'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'sjl/gundo.vim'
" Bundle 'jumski/ultisnips'
" Bundle 'duskhacker/sweet-rspec-vim'
" Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/vimux'
Bundle 'jumski/vimux-ruby-test'
Bundle 'jayferd/eco.vim'
Bundle 'sickill/vim-pasta'
Bundle 'nono/vim-handlebars'
Bundle 'jgdavey/vim-blockle'

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
let VimuxHeight = "5"

" gundo toggler
nnoremap <leader>gu :GundoToggle<CR>

" mappings for ctrlp
" let g:ctrlp_map = '<leader>z'
" let g:ctrlp_map = '<leader>v'
" let g:ctrlp_cmd = 'CtrlPMRU'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$5\|\.hg$\|\.svn$',
"   \ 'file': '\.exe$\|\.so$\|\.dll$',
"   \ }
" let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" \ 'link': 'some_bad_symbolic_links',

" set leader for easy motion
let g:EasyMotion_Leader_key = ',,'

" set commant-t window height
let g:CommandTMaxHeight=10

" require matchit manually
runtime macros/matchit.vim

" powerline settings
let g:Powerline_symbols = 'fancy'

" coffee script
let coffee_compile_vert = 1

" use vim-pasta in coffeescript
let g:pasta_disabled_filetypes = ["python", "markdown", "coffee"]

