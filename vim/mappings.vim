""""" CUSTOM MAPPINGS
noremap <leader>` :CommandT<cr>
noremap <C-k><C-k> <C-w><C-w>
noremap <C-k>k <C-w><C-w>
imap <C-w> <C-o><C-w> " this allows all window commands in insert mode and i'm not accidentally deleting words anymore :-)"
" imap ;; <esc> " shourtcut for going to normal mode from insert mode

" tab mappings
nmap <silent> <leader>c :tabnew %<CR>
nmap <silent> <leader><Tab> :tabp<CR>
nmap <silent> <leader>f :tabn<CR>
nmap <silent> <leader>x :tabclose<CR>

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

cmap w!! w !sudo tee >/dev/null %
" touch current file (useful for triggering guard)
" noremap <silent><leader>r :call system('touch ' . expand("%:p"))<cr> 
