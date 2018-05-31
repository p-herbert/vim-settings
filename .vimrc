" vim:foldmethod=marker:foldlevel=0
" =============================================================================
" Package management {{{
" =============================================================================

" Disable bundles by adding full path to bundle
let g:pathogen_blacklist=[]

" Load bundles using pathogen
filetype off
execute pathogen#infect()
call pathogen#helptags()
" }}}
" =============================================================================
" General settings {{{
" =============================================================================

syntax on                           " Syntax highlighting
filetype on                         " Try to detect filetypes
filetype plugin indent on    	    " Enable loading indent file for filetype
set number                          " Display line numbers

" Color scheme
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Moving/Editing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab expandtab autoindent
set foldmethod=indent
set foldlevel=20
set backspace=2
set tw=79              " Set the maximum column width
set wrap               " Wrap long lines
set clipboard=unnamed
set splitright

" Messages, Info, Status
set ruler          " Show current column and row in statusbar
set laststatus=2
set showtabline=0   " Disable tabs
set noshowmode      " Disable message on last line

" Patterns
set ignorecase      " Default to using case insensitive searches,
set smartcase       " unless uppercase letters are used in the regex.
set hlsearch!      " Highlight all search matches

" Command mode autocomplete
set wildmenu
set wildmode=longest,list,full

" Ignore
set wildignore+=*/node_modules,*/.git,*/.meteor,*/__generated__

" Reading/Writing
set autoread

" Set delays
set timeoutlen=500 ttimeoutlen=0

" Completion
set completeopt=menuone,longest
set omnifunc=syntaxcomplete#Complete
set pumheight=6

" Tag files
set tags=./tags,tags,~/.vimtags
" }}}
" =============================================================================
" Mappings {{{
" =============================================================================

" Remap moving between windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Tab mappings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

map <leader>T <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>w :%s/[ \t]\+$//g<CR>g;
nmap <leader>A <Esc>:Ack!
nmap <leader>d :Gvdiff<CR>
nmap <leader>b :Gblame<CR>
nmap <leader>s :Gstatus<CR>
nmap <leader>e :Errors<CR>
nmap <leader>S :Shell<Space>
nmap <leader>D :Shell git diff --cached<CR>:set ft=diff<CR>
nmap <leader>p :Prettier<CR>:w<CR>
nmap <leader>h :vsp \| :Glog -- % <CR><CR> \| :copen<CR>
nmap <leader>G :Grepper -query<space>

" Map HighlightRepeats function
vn <leader>R :call HighlightRepeats()<CR>

" Patch for delimitMate
imap <silent> <BS> <C-R>=YcmOnDeleteChar()<CR><Plug>delimitMateBS

" Function keys
:nnoremap <F5> :set hlsearch!<CR>
call togglebg#map("<F6>")       " load the background script
map <F8> :TagbarToggle<CR>
" }}}
" =============================================================================
" Commands {{{
" =============================================================================

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
command! -nargs=1 Find :vim /<args>/gj % | :copen
" }}}
" =============================================================================
" Statusline {{{
" =============================================================================

" Fugitive
set statusline+=%{fugitive#statusline()}

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}
" =============================================================================
" Package settings {{{
" =============================================================================

" Tern settings
let g:tern_map_keys=1
let g:tern_show_argument_hints="on_hold"
let g:tern_show_signature_in_pum=1

" SnipMate author
let g:snips_author='Peter Herbert'

" SuperTab settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabMappingForward = "<M-space>"
let g:SuperTabMappingBackward = "<c-M-space>"

" Command-T settings
let g:CommandTMaxFiles=20000

" Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5
let g:syntastic_echo_current_error = 1
let g:syntastic_cursor_column = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "\u2718"
let g:syntastic_style_error_symbol = "\u2714"
let g:syntastic_warning_symbol = "∆"
let g:syntastic_style_warning_symbol = "≈"

" Powerline settings
let g:Powerline_symbols = 'fancy'

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" vim-qf settings
let g:qf_mapping_ack_style = 1

" vim-terraform settings
let g:terraform_fmt_on_save = 1
let g:terraform_align = 1
let g:terraform_fold_sections = 1

" YCM settings
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_use_ultisnips_completer = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_filetype_blacklist = {
\  'tagbar' : 1,
\  'nerdtree' : 1,
\}

" Easytags settings
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_file = 1
let g:easytags_languages = {
\   'javascript': {
\       'args': ['-f'],
\       'cmd': 'jsctags',
\       'recurse_flag': ''
\   }
\}

" Gundo settings
let g:gundo_preview_bottom = 1

" delimitMate settings
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Ack settings
let g:ack_use_dispatch = 1
let g:ack_autoclose = 1

" vim-grepper settings
let g:grepper = {
    \ 'tools': ['ack', 'rg'],
    \ 'ack': {
    \   'grepprg': 'ack -s -H --nopager --nocolor --column',
    \   'grepformat': '%f:%l:%c:%m,%f:%l:%m'
    \ }
\}
let g:grepper.dir= 'repo,cwd,filecwd'

" vim-prettier setttings
let g:prettier#exec_cmd_async = 1
" }}}
" =============================================================================
" augroup {{{
" =============================================================================

augroup cursor
    autocmd!
    :autocmd InsertEnter * set cul
    :autocmd InsertLeave * set nocul
augroup END

augroup NERDTree
    " Close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END

" Set filetype
augroup filetypedetect
 au! BufRead,BufNewFile *.m,*.oct set filetype=octave
 au! BufRead,BufNewFile *.sas set filetype=sas
 au! BufRead,BufNewFile *.log set filetype=log
 au! BufRead,BufNewFile *.r,*.R set filetype=r
 au! BufRead,BufNewFile *.xml,*.xsd set filetype=xml
 au! BufRead,BufNewFile *.sql set filetype=sql
 au! BufRead,BufNewFile *.py set filetype=python
 au! BufRead,BufNewFile *.pl set filetype=perl
 au! BufRead,BufNewFile *.js set filetype=javascript | setlocal omnifunc=tern#Complete
 au! BufRead,BufNewFile *.json set filetype=json
 au! BufRead,BufNewFile *.tex set filetype=tex
 au! FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR> | nnoremap <buffer><silent>q :q<cr>
augroup END
" }}}
" =============================================================================
" Highlight {{{
" =============================================================================

" Change cursor by mode for iterm2
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue

" Highlight background when text goes over 79 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.\+/

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
2match ExtraWhitespace /[ \t]\+$/
" }}}
" =============================================================================
" Terminal settings {{{
" =============================================================================

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  "let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" =============================================================================
" Functions {{{
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

" Highlight duplicate lines in file
function! HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

" Autofix with eslint
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        checktime
    endif
endfunction

" Patch for delimitMate
function! YcmOnDeleteChar()
  if pumvisible()
    return "\<C-y>"
  endif
  return ""
endfunction
" }}}
" =============================================================================

