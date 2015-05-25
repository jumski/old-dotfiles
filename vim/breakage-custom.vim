
" vim-fireplace
" nmap <C-a> cpp
"</C-a> autocmd BufReadPost Quickfix nmap q :cclose<cr>
autocmd BufReadPost *.clj nmap <silent> :silent norm <C-a> <C-a>cppg,
autocmd BufReadPost *.clj nmap <silent> :silent norm <C-x> <C-x>cppg,
autocmd BufReadPost *.clj nmap <silent> :silent norm cpp cppg,

" <Plug>(sexp_swap_element_forward)
" autocmd BufReadPost *.clj nmap <C-right> <Plug>(sexp_swap_element_forward)cppg,
" autocmd BufReadPost *.clj nmap <C-left> <Plug>(sexp_swap_element_backward)cppg,
" autocmd BufReadPost *.clj nmap <C-right> >ecppg,
" autocmd BufReadPost *.clj nmap <C-left> <ecppg,
autocmd BufReadPost *.clj nmap <silent> >e <Plug>(sexp_swap_element_forward)cppg,
autocmd BufReadPost *.clj nmap <silent> <e  <Plug>(sexp_swap_element_backward)cppg,
