
" more useful leader
let mapleader=","
let g:mapleader = ","

noremap <leader>d :Dispatch<cr>

" experimental ESC mapping
inoremap kj <esc>

""""" CUSTOM MAPPINGS
noremap <leader>` :CommandT<cr>
" noremap <C-k><C-k> <C-w><C-w>
" noremap <C-k>k <C-w><C-w>
imap <C-w> <C-o><C-w> " this allows all window commands in insert mode and i'm not accidentally deleting words anymore :-)"
" imap ;; <esc> " shourtcut for going to normal mode from insert mode

" tab mappings
nmap <silent> <leader>c :tabnew %<CR>
nmap <silent> <leader><Tab> :tabp<CR>
nmap <silent> <leader>f :tabn<CR>
nmap <silent> <leader>x :tabclose<CR>

" toggle hlsearch
nmap <leader>h :se invhlsearch<CR>

" toggle paste
nmap <leader>p :se invpaste<CR>

" reformat whole file
noremap <leader>g mggg=G'g

" disable Ex mode, use its mapping for repeating a macro
nmap Q @@

" save with C-S
noremap <silent> <C-s> :update<CR>
vnoremap <silent> <C-s> <C-C>:update<CR>
inoremap <silent> <C-s> <Esc>:update<CR>

" open file under curson in vsplit
" nmap <C-X>gf :vs %<CR>gf

noremap  <Up> ""
noremap! <Up> <Esc>
noremap  <Down> ""
noremap! <Down> <Esc>
noremap  <Left> ""
noremap! <Left> <Esc>
noremap  <Right> ""
noremap! <Right> <Esc>
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" easy access/surce vimrc and other
nnoremap <leader>vs :source ~/.vimrc<CR>
nnoremap <leader>vm :tabnew ~/dotfiles/vim/mappings.vim<cr>
nnoremap <leader>vp :tabnew ~/dotfiles/vim/plugins.vim<cr>
nnoremap <leader>vv :tabnew ~/dotfiles/vim/plugins.vim<cr>:vs ~/dotfiles/vim/settings.vim<cr>:sp ~/dotfiles/vim/mappings.vim<cr><C-w>h:sp ~/dotfiles/vim/projections.vim<cr>
  " \ :sp     ~/dotfiles/settings.vim<cr>
  " \ :sp     ~/dotfiles/mappings.vim<cr>
  " \ :vs     ~/dotfiles/macros.vim<cr><c-k><c-k>
nnoremap <leader>vu :UltiSnipsEdit<cr>
nnoremap <leader>vb :NeoBundleInstall<cr>
nnoremap <leader>vp :tabnew config/projections.json<cr>

" some custom stuff
nnoremap <leader>op :15sp /home/jumski/dropbox/projects/`basename \`pwd\``/todos.txt<cr>
nnoremap <leader>ow :15sp `/home/jumski/dotfiles/bin/worklog-path`<cr>
" nnoremap <leader>oW :Ex $(dirname `/home/jumski/dotfiles/bin/worklog-path`)<cr>

" Glbrowse
nnoremap <leader>og :Glbrowse<cr>

" Split line(opposite to S-J joining line)
" nnoremap <C-J> gEa<CR><ESC>

cmap w!! w !sudo tee >/dev/null %

cmap wqq wq

" Convert to Ruby 1.9 hash syntax
noremap <leader>9 :s/:\(\S\+\)\s\+=>\s\+/\1: /g<cr>

" goto next/previous Ack result
nnoremap <leader>n :cnext<CR>
nnoremap <leader>N :cprevious<CR>

" `a jumps to line and column marked ma
" 'a jumps only to line marked ma
" so we swap each other because ' have easy access
noremap ' `
noremap ` '

" Y yanks to the end of line
map Y y$

" keeps visual mode after indenting
vmap > >gv
vmap < <gv

" select last changed/pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" plugin specific mappings
nnoremap <leader>a :RunRubyFocusedTest<CR>
nnoremap <leader>q :RunRubyFocusedContext<CR>
nnoremap <leader>t :RunAllRubyTests<CR>
nnoremap <leader>Q :CloseVimTmuxPane<CR>
" nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>gu :GundoToggle<CR>

" replase word under cursor in whole file
nnoremap <leader>: "xyiw:%s/<C-R>x/

" Ag search
nnoremap \ :tabnew<CR>:Ag<space>
" Ag search for word under cursor
nnoremap <leader>\ "xyiw:tabnew<CR>:Ag <C-R>x<space>
vnoremap \ "xy:tabnew<CR>:Ag "<C-R>x"<space>

" Rails specific
map <leader>rr :topleft :tabnew config/routes.rb<cr>
map <leader>rg :topleft 100 :tabnew Gemfile<cr>

" fugitive shortcuts
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>

" clojure mappings
nnoremap <leader>R :Require<CR>

" improve movement on wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap $ g$
nnoremap ^ g^
nnoremap 0 g0
vnoremap j gj
vnoremap k gk
vnoremap $ g$
vnoremap ^ g^
vnoremap 0 g0

" keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv

" same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

function! SpecCommandForCurrentFile(alternate_letter)
  let basename = expand("%:p:t:r")
  exec ":".a:alternate_letter."spec ".basename."!"
endfunction
cmap A! call SpecCommandForCurrentFile("R")<cr>
cmap V! call SpecCommandForCurrentFile("V")<cr>
cmap S! call SpecCommandForCurrentFile("S")<cr>
cmap T! call SpecCommandForCurrentFile("T")<cr>
