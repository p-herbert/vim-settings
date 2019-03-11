" =============================================================================
" Javascript settings
" =============================================================================

set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
set makeprg=jest

" =============================================================================
" Mappings
" =============================================================================

nmap <F1> :!node %<CR>

" JSHint
nmap <F2> :JSHint<CR>

" Mocha
nmap <F3> :!mocha %<CR>

" Search using ack
map <leader>A :Ack! --type=js --type=react --type=graphql<space>

" vim-grepper settings
let g:grepper.ack.grepprg = 'ack -s -H --nopager --nocolor --column --type=js --type=react --type=graphql'

" =============================================================================
" Package settings
" =============================================================================

let g:jsx_ext_required = 0              " Enable jsx for js files as well
let g:javascript_plugin_flow = 1        " Enable syntax highlighting for Flow

" Prettier settings
let g:prettier#config#tab_width = 4     " Number of spaces per indentation level
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#config#parser = 'babylon'

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

