
" vim-fireplace
" nmap <C-a> cpp
"</C-a> autocmd BufReadPost Quickfix nmap q :cclose<cr>
autocmd BufReadPost *.clj nmap <C-a> <C-a>cppg,
autocmd BufReadPost *.clj nmap <C-x> <C-x>cppg,
