" Javascript Settings
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1

nmap <F1> :!node %<CR>

" JSHint
nmap <F2> :JSHint<CR>

" Mocha
nmap <F3> :!mocha %<CR>

" Comment out lines of code
map <S-C> :norm i// <CR>

" Enable jsx for js files as well
let g:jsx_ext_required = 0

" number of spaces per indentation level
let g:prettier#config#tab_width = 4

let g:prettier#autoformat = 0
let g:prettier#config#parser = 'babylon'

" Syntastic plugin
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = ['--fix']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'
