
Bundle 'altercation/vim-colors-solarized'

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
au BufNewFile,BufRead tmuxgo setfiletype bash
au BufNewFile,BufRead rbtmux setfiletype ruby

