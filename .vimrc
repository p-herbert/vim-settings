" =============================================================================
" Package Management
" =============================================================================

" Disable bundles by adding full path to bundle
let g:pathogen_blacklist=[]

" Load bundles using pathogen
filetype off
execute pathogen#infect()
call pathogen#helptags()

" =============================================================================
" General Settings
" =============================================================================

syntax on                           " Syntax highlighting
filetype on                         " Try to detect filetypes
filetype plugin indent on           " Enable loading indent file for filetype
set number                          " Display line numbers

" Color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
2match ExtraWhitespace /[ \t]\+$/

" Moving/Editing
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab expandtab autoindent
set foldmethod=indent
set foldlevel=20
set backspace=2
set tw=79                           " Set the maximum column width
set wrap                            " Wrap long lines
set clipboard=unnamed
set splitright

" Messages, Info, Status
set ruler                           " Show current column and row in statusbar
set laststatus=2
set showtabline=0                   " Disable tabs
set noshowmode                      " Disable message on last line

" Patterns
set ignorecase                      " Default to using case insensitive searches
set smartcase                       " Unless uppercase letters are used in the regex
set hlsearch!                       " Highlight all search matches

" Command mode autocomplete
set wildmenu
set wildmode=longest,list,full

" Ignore
set wildignore+=*/node_modules,*/.git,*/.meteor,*/__generated__,*/build,*/amplify,*/dist,*/tmp,*/patches,*.png,*.svg,*.jpg,*.ico,.DS_Store

" Reading/Writing
set autoread
set updatetime=100

" Set delays
set timeoutlen=500 ttimeoutlen=0

" Completion
set completeopt=menuone,longest
"set omnifunc=syntaxcomplete#Complete
set pumheight=10

" Tag files
set tags=./tags,tags,$HOME/.vimtags

" Undo
set undofile
set undodir=$HOME/.vim/undo

" =============================================================================
" Mappings
" =============================================================================

" Remap moving between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Tab mappings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Map HighlightRepeats function
vn <leader>R :call HighlightRepeats()<CR>

" Remove whitespace
map <leader>w :%s/[ \t]\+$//g<CR>g;

" Git
nmap <leader>d :Gvdiff<CR>
nmap <leader>b :Git blame<CR>
nmap <leader>ci :!git add % && git ci<CR>
nmap <leader>s :Git status<CR>
nmap <leader>h :vsp \| :Glog -- % <CR><CR> \| :copen<CR>

" Function keys
:nnoremap <F5> :set hlsearch!<CR>

" Buffers
nmap ]b :bn<CR>
nmap [b :bp<CR>

" fzf
nnoremap <C-space> :Rg<CR>
nnoremap <S-space> :GFiles<CR>
nnoremap <CS-space> :Files<CR>

" =============================================================================
" Commands
" =============================================================================

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
command! -nargs=1 Find :vim /<args>/gj % | :copen

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" =============================================================================
" Package Mappings
" =============================================================================

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" gundo.vim
map <leader>g :GundoToggle<CR>

" coc
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible()
                              \? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Navigate diagnostic
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Applying code actions to the selected code block
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ac <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" =============================================================================
" Package Settings
" =============================================================================

" NERDTree settings
let NERDTreeShowHidden = 1
let NERDTreeIgnore = [ '\.git$[[dir]]', '.DS_Store' ]

" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" gundo.vim
let g:gundo_preview_bottom = 1
let g:gundo_prefer_python3 = 1

" vim-gitgutter
let g:gitgutter_highlight_lines = 0

" coc
let g:coc_filetype_map = {
  \ 'yaml.docker-compose': 'dockercompose',
  \ }

" =============================================================================
" augroup
" =============================================================================
augroup cursor
    autocmd!
    :autocmd InsertEnter * set cul
    :autocmd InsertLeave * set nocul
augroup END

augroup NERDTree
    " Open a NERDTree automatically when vim starts up if no files were specified
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | wincmd p | endif

    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Set filetype
augroup filetypedetect
 au! BufRead,BufNewFile *.tex, *.txt, *.md setlocal spell
 au! FileType gitcommit setlocal spell
 au! FileType fugitiveblame nmap <leader>q gq
 au! FileType qf nnoremap <buffer> <cr> <cr>:cclose<cr> | nnoremap <buffer><silent>q :q<cr>
 au FileType yaml if bufname("%") =~# "docker-compose.yml" | set ft=yaml.docker-compose | endif
 au FileType yaml if bufname("%") =~# "compose.yml" | set ft=yaml.docker-compose | endif
augroup END

" =============================================================================
" Functions
" =============================================================================

function! s:RunShellCommand(cmdline)
  let isfirst = 1
  let words = []
  for word in split(a:cmdline)
    if isfirst
      let isfirst = 0  " don't change first word (shell command)
    else
      if word[0] =~ '\v[%#<]'
        let word = expand(word)
      endif
      let word = shellescape(word, 1)
    endif
    call add(words, word)
  endfor
  let expanded_cmdline = join(words)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:  ' . a:cmdline)
  call setline(2, 'Expanded to:  ' . expanded_cmdline)
  call append(line('$'), substitute(getline(2), '.', '=', 'g'))
  silent execute '$read !'. expanded_cmdline
  1
endfunction

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
