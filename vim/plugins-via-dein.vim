if &compatible
  set nocompatible
endif
set runtimepath+=/home/jumski/.dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/jumski/.vim/bundle')
  call dein#begin('/home/jumski/.vim/bundle')

  call dein#add('/home/jumski/.dein/repos/github.com/Shougo/dein.vim')
	call dein#add('SirVer/ultisnips')
	call dein#add('Lokaltog/vim-powerline')

	call dein#add('Shougo/deoplete.nvim')
	if !has('nvim')
	  call dein#add('roxma/nvim-yarp')
	  call dein#add('roxma/vim-hug-neovim-rpc')
	endif

	call dein#add('jumski/vim-colors-solarized')
	" call dein#add('delimitMate.vim')
	call dein#add('logstash.vim')
	call dein#add('godlygeek/tabular')
	call dein#add('kana/vim-fakeclip')
	call dein#add('kchmck/vim-coffee-script')

	call dein#add('Glench/Vim-Jinja2-Syntax')
	call dein#add('chase/vim-ansible-yaml')



	call dein#add('matchit.zip')
	call dein#add('michaeljsmith/vim-indent-object')
	call dein#add('repeat.vim')
	call dein#add('scrooloose/syntastic')
	" call dein#add('tomtom/tcomment_vim')
	call dein#add('tpope/vim-abolish')
	call dein#add('tpope/vim-endwise')
	call dein#add('tpope/vim-eunuch')
	call dein#add('tpope/vim-fugitive')
	call dein#add('tpope/vim-commentary')
	call dein#add('tpope/vim-rhubarb')

	call dein#add('christoomey/vim-tmux-navigator')
	call dein#add('tpope/vim-git')
	call dein#add('tpope/vim-haml')
	call dein#add('tpope/vim-markdown')
	call dein#add('tpope/vim-rails')
	call dein#add('tpope/vim-surround')
	call dein#add('tpope/vim-unimpaired')
	call dein#add('tpope/vim-bundler')
	call dein#add('tpope/vim-rake')
	call dein#add('tpope/vim-sleuth')
	call dein#add('tpope/vim-dispatch')
	call dein#add('tpope/vim-capslock')
	call dein#add('guns/vim-clojure-static')
	call dein#add('guns/vim-clojure-highlight')
	call dein#add('tpope/vim-classpath')



	call dein#add('tpope/vim-fireplace')
	" call dein#add('tpope/vim-leiningen')
	call dein#add('tpope/vim-dotenv')

	call dein#add('tpope/vim-projectionist')
	call dein#add('vim-ruby/vim-ruby')
	call dein#add('mattn/gist-vim')
	" " call dein#add('vim-scripts/ack.vim')
	call dein#add('rking/ag.vim')
	call dein#add('vim-scripts/file-line')
	call dein#add('ecomba/vim-ruby-refactoring')
	call dein#add('sjl/gundo.vim')
	call dein#add('tpope/vim-vinegar')
	call dein#add('tpope/vim-obsession')
	call dein#add('sickill/vim-pasta')
	call dein#add('nono/vim-handlebars')
	call dein#add('jgdavey/vim-blockle')





	call dein#add('Shougo/vimproc')
	call dein#add( "DataWraith/auto_mkdir")
	call dein#add('bronson/vim-visual-star-search')
	" call dein#add('othree/yajs.vim')
	" call dein#add('jelera/vim-javascript-syntax')
	call dein#add('sheerun/vim-polyglot')
	call dein#add('slim-template/vim-slim')
	call dein#add('mattn/webapi-vim')
	call dein#add('christoomey/vim-tmux-navigator')
	call dein#add('mxw/vim-jsx')





	call dein#add('kana/vim-textobj-user')
	call dein#add('nelstrom/vim-textobj-rubyblock')
	call dein#add('abijr/colorpicker')
	call dein#add('othree/html5.vim')
	call dein#add('closetag.vim')
	call dein#add('junegunn/rainbow_parentheses.vim')
	call dein#add('ekalinin/Dockerfile.vim')
	call dein#add('nginx.vim')

	call dein#add('lucapette/vim-ruby-doc')
	call dein#add('danchoi/ri.vim')

	call dein#add('haya14busa/incsearch.vim')

	call dein#add('jaxbot/semantic-highlight.vim')

	"call dein#add('mhinz/vim-sayonara')

	call dein#add('suan/vim-instant-markdown')
	call dein#add('guns/vim-sexp')

	call dein#add('tpope/vim-sexp-mappings-for-regular-people')
	call dein#add('beloglazov/vim-online-thesaurus')

	call dein#add('vimwiki/vimwiki')

	call dein#add('nathanaelkane/vim-indent-guides')
	call dein#add('tommcdo/vim-exchange')

	call dein#add('junegunn/goyo.vim')
	call dein#add('junegunn/limelight.vim')

	call dein#add('zeavim.vim')

	call dein#add('ludovicchabant/vim-gutentags' )

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable







