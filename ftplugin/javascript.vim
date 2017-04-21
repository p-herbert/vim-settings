" Javascript Settings
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
set tabstop=4
set shiftwidth=4
set softtabstop=0
set noexpandtab smartindent

nmap <F1> :!node %<CR>

" JSHint
nmap <F2> :JSHint<CR>

" Mocha
nmap <F3> :!mocha %<CR>

" Comment out lines of code
map <S-C> :norm i// <CR>

" Enable jsx for js files as well
let g:jsx_ext_required = 0

" Syntastic plugin
""let g:syntastic_javascript_checkers = ['jshint']
""let g:syntastic_javascript_checkers = ['eslint', 'standard']
let g:syntastic_javascript_checkers = ['eslint']
""let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
