" Compile to pdf
nmap <F1> :!pdflatex -output-directory %:h %<CR>

let g:syntastic_tex_checkers = [ 'chkTex', 'proselint', 'text/textlint' ]
