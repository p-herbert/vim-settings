" Check wellformedness of xml
autocmd FileType xml nmap <F1> :!xmllint --noout %<CR>

" XML Settings
autocmd FileType xml set foldmethod=syntax | set tabstop=2 | set shiftwidth=2 | set softtabstop=2 | set autoindent | let xml_syntax_folding=1
