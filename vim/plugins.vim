NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'delimitMate.vim'
" NeoBundle 'gmarik/ide-popup.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'lastpos.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'jumski/Conque-Shell'
NeoBundle 'matchit.zip'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'repeat.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-rake'
NeoBundle 'vim-ruby/vim-ruby'
" NeoBundle 'vim-scripts/ack.vim'
NeoBundle 'epmatsw/ag.vim'
NeoBundle 'vim-scripts/file-line'
" NeoBundle 'ZoomWin'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'sjl/gundo.vim'
" NeoBundle 'jumski/ultisnips'
" NeoBundle 'duskhacker/sweet-rspec-vim'
" NeoBundle 'kien/ctrlp.vim'
NeoBundle 'vim-scripts/vimux'
NeoBundle 'jumski/vimux-ruby-test'
NeoBundle 'jayferd/eco.vim'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'jgdavey/vim-blockle'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'Shougo/vimproc'

""""""""" DISABLED PLUGINS
" NeoBundle 'php.vim'
" NeoBundle 'samsonw/vim-task'
" NeoBundle 'tpope/vim-cucumber'
" NeoBundle 'TTCoach' " touch typing coach
" NeoBundle 'vim-scripts/marvim' " macro persistent storage
" NeoBundle 'vimwiki'
" NeoBundle 'wincent/Command-T' " textmate-like searching throught project

"===============================
"    plugin specific options
"===============================
let VimuxHeight = "50"
let VimuxOrientation = "h"

" let g:syntastic_disabled_filetypes = ["haml", "sass"]
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': ['ruby', 'erb', 'javascript', 'coffee'],
                           \ 'passive_filetypes': [] }

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
" let g:CommandTMaxHeight=10

" require matchit manually
runtime macros/matchit.vim

" powerline settings
let g:Powerline_symbols = 'fancy'

" coffee script
let coffee_compile_vert = 1

" use vim-pasta in coffeescript
let g:pasta_disabled_filetypes = ["python", "markdown", "coffee", "haml", "sass"]


" check if all is installed
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif
