NeoBundle 'jumski/vim-colors-solarized'
NeoBundle 'delimitMate.vim'
NeoBundle 'vim-puppet'
" NeoBundle 'gmarik/ide-popup.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'lastpos.vim'

NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'Lokaltog/vim-powerline'
" NeoBundle 'bling/vim-airline'
NeoBundle 'matchit.zip'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'repeat.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'tpope/vim-git'
NeoBundle 'tpope/vim-haml'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'tpope/vim-bundler'
NeoBundle 'tpope/vim-rake'
NeoBundle 'tpope/vim-sleuth'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'guns/vim-clojure-static'
NeoBundle 'tpope/vim-classpath'



NeoBundle 'tpope/vim-fireplace'
NeoBundle 'tpope/vim-projectile'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'mattn/gist-vim'
" NeoBundle 'vim-scripts/ack.vim'
NeoBundle 'epmatsw/ag.vim'
NeoBundle 'vim-scripts/file-line'
NeoBundle 'ecomba/vim-ruby-refactoring'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'SirVer/ultisnips'


" NeoBundle 'duskhacker/sweet-rspec-vim'
NeoBundle 'vim-scripts/vimux'
NeoBundle 'jumski/vimux-ruby-test'
NeoBundle 'jayferd/eco.vim'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'nono/vim-handlebars'
NeoBundle 'jgdavey/vim-blockle'





NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'Shougo/vimproc'
NeoBundle "DataWraith/auto_mkdir"
" NeoBundle 'Shougo/neocomplcache.vim'
" NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'bronson/vim-visual-star-search'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'christoomey/vim-tmux-navigator'





NeoBundle 'kana/vim-textobj-user'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'abijr/colorpicker'
NeoBundle 'othree/html5.vim'
NeoBundle 'closetag.vim'
NeoBundle 'kien/rainbow_parentheses.vim'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'OrangeT/vim-csharp'
NeoBundle 'ekalinin/Dockerfile.vim'



" NeoBundle 'tommcdo/vim-exchange'
" NeoBundle 'AndrewRadev/splitjoin.vim'
" NeoBundle 'AndrewRadev/switch.vim'

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

let g:ycm_complete_in_comments_and_strings = 1

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

""" ULTISNIPS
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir = "~/dotfiles/ultisnips"
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "../../../dotfiles/ultisnips"]
let g:UltiSnipsExpandTrigger = "<C-z>"
augroup filetypedetect
  au! BufRead,BufNewFile *_spec.rb		set filetype=rspec.ruby
augroup END
" g:UltiSnipsListSnippets                <c-tab>

let g:gist_clip_command = 'xclip -selection clipboard'

" check if all is installed
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"""""""""""""""""""" custom functions
fu! WriteCursorLastPosition()
  let output = system('echo ' . getreg('%') . ':' . line('.') . ' > .cursor_last_position')
endfunction

if !exists("b:jumski_write_rspec_guide")
  let b:jumski_write_rspec_guide = 1

  au BufWritePost *_spec.rb call WriteCursorLastPosition()
endif

" rainbow parenthesis
au VimEnter * RainbowParenthesesActivate
au VimEnter * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au BufRead * RainbowParenthesesActivate
au BufRead * RainbowParenthesesLoadRound
" au Syntax *.clj RainbowParenthesesLoadSquare
" au Syntax *.clj RainbowParenthesesLoadBraces
