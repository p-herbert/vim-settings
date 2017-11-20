" =============================================================================
" Javascript settings
" =============================================================================

set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1

" =============================================================================
" Mappings
" =============================================================================

nmap <F1> :!node %<CR>

" JSHint
nmap <F2> :JSHint<CR>

" Mocha
nmap <F3> :!mocha %<CR>

" Comment out lines of code
map <S-C> :norm i// <CR>

" Search using ack
map <leader>j <ESC>:Ack! --type=js --type=react<space>

" =============================================================================
" Package settings
" =============================================================================

let g:jsx_ext_required = 0              " Enable jsx for js files as well

" Prettier settings
let g:prettier#config#tab_width = 4     " Number of spaces per indentation level
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#config#parser = 'babylon'

" Syntastic settings
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_args = ['--fix']
let g:syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

" Conceal settings
set conceallevel=1
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_noarg_arrow_function = "λ"
let g:javascript_conceal_underscore_arrow_function = "λ"

