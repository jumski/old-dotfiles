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
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rake'
Bundle 'vim-ruby/vim-ruby'
Bundle 'vim-scripts/ack.vim'
Bundle 'vim-scripts/file-line'
" Bundle 'ZoomWin'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'sjl/gundo.vim'
" Bundle 'jumski/ultisnips'
" Bundle 'duskhacker/sweet-rspec-vim'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/vimux'
Bundle 'pgr0ss/vimux-ruby-test'
Bundle 'jayferd/eco.vim'

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
let VimuxHeight = "30"

" mappings for ctrlp
" let g:ctrlp_map = '<leader>z'
let g:ctrlp_map = '<leader>v'
let g:ctrlp_cmd = 'CtrlPMRU'
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|\.hg$\|\.svn$',
"   \ 'file': '\.exe$\|\.so$\|\.dll$',
"   \ }
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
" \ 'link': 'some_bad_symbolic_links',

" set leader for easy motion
let g:EasyMotion_Leader_key = ',,'

" set commant-t window height
let g:CommandTMaxHeight=10

" require matchit manually
runtime macros/matchit.vim

autocmd User Rails Rnavcommand javascripts app/assets/javascripts/ -suffix=.js,.js.erb,.js.coffee,.js.coffee.erb
autocmd User Rails Rnavcommand templates app/assets/templates/ -suffix=.jst,.jst.eco,.eco
autocmd User Rails Rnavcommand support spec/support/ -suffix=.rb
autocmd User Rails Rnavcommand uploaders app/uploaders/ -suffix=.rb
autocmd User Rails Rnavcommand overrides app/overrides/ -suffix=.rb
autocmd User Rails Rnavcommand factories spec/factories/ -suffix=.rb
autocmd User Rails Rnavcommand admin app/admin/ -suffix=.rb
