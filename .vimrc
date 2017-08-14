" Add path to powerline
set rtp+=/usr/local/lib/python2.7/site-packages/powerline/bindings/vim/

filetype off
execute pathogen#infect()
call pathogen#helptags()

" Vertical Split: Ctrl+w + v
" Horizontal Split: Ctrl+w + s
" Close current windows: Ctrl+w + q

" Change cursor by mode for iterm2
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  "let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  "let &t_SR = "\<Esc>]50;CursorShape=2\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
:autocmd InsertEnter * set cul
:autocmd InsertLeave * set nocul

map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Tab mappings
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

set backspace=2
set clipboard=unnamed

map <leader>td <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <C-n> :NERDTreeToggle<CR>
map <leader>w :%s/[ \t]\+$//g<CR>g;
map <F8> :TagbarToggle<CR>
nmap <leader>A <Esc>:Ack!
nmap <leader>d :Gvdiff<CR>
nmap <leader>b :Gblame<CR>
nmap <leader>ci :!git add % && git ci<CR>
nmap <leader>s :Gstatus<CR>

" Function Keys
" Highlight all search matches
:set hlsearch!
:nnoremap <F5> :set hlsearch!<CR>

" load the background script
call togglebg#map("<F6>")

" In normal mode insert the current datestamp
:nnoremap <F7> "=strftime("%Y-%m-%d %H:%M:%S")<CR>P

" If buffer modified, update any 'LAST modified:' in the first 20 lines.
" 'LAST Modified:' can have up to 10 characters before (they are retained).
" " Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}LAST Modified:\).*#\1' .
			    \ strftime(' %Y-%m-%d %H:%M:%S') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()

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

command! -range=% HighlightRepeats <line1>,<line2>call HighlightRepeats()

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
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

command! -nargs=1 Find :vim /<args>/gj % | :copen

" Map HighlightRepeats function
vn <leader>R :call HighlightRepeats()<CR>

filetype on                      " try to detect filetypes
filetype plugin indent on    	 " enable loading indent file for filetype

" Set FileType
augroup filetypedetect
 au! BufRead,BufNewFile *.m,*.oct set filetype=octave
 au! BufRead,BufNewFile *.sas set filetype=sas
 au! BufRead,BufNewFile *.log set filetype=log
 au! BufRead,BufNewFile *.r,*.R set filetype=r
 au! BufRead,BufNewFile *.xml,*.xsd set filetype=xml
 au! BufRead,BufNewFile *.sql set filetype=sql
 au! BufRead,BufNewFile *.py set filetype=python
 au! BufRead,BufNewFile *.pl set filetype=perl
 au! BufRead,BufNewFile *.js set filetype=javascript
 au! BufRead,BufNewFile *.json set filetype=json
 au! BufRead,BufNewFile *.tex set filetype=tex
augroup END

syntax on                        " syntax highlighing
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
:set number

" Show current column and row in statusbar
:set ruler
" Set the maximum column width and wrap long lines
:set tw=79
:set wrap

" Highlight background when text goes over 79 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%80v.\+/

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
2match ExtraWhitespace /[ \t]\+$/

" Global text settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab expandtab autoindent
set foldmethod=indent
set foldlevel=20

" Add Fugitive statusline
set statusline+=%{fugitive#statusline()}

" Set snipMate author
let g:snips_author='Peter Herbert'

let g:SuperTabDefaultCompletionType = "context"

" Remap SuperTab
let g:SuperTabMappingForward = "<M-space>"
let g:SuperTabMappingBackward = "<c-M-space>"

set completeopt=menuone,longest,preview

" Set the maximum number of files for Command-T
let g:CommandTMaxFiles=20000

" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Enable autoread to reload any files from files when checktime is called and
" the file is changed
set autoread

" Autofix with eslint
function! SyntasticCheckHook(errors)
    if !empty(a:errors)
        checktime
    endif
endfunction

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

" Powerline settings
let g:Powerline_symbols = 'fancy'

set laststatus=2
set showtabline=2
set noshowmode

" Command mode autocomplete
set wildmenu
set wildmode=longest,list,full

" Ignore
set wildignore+=*/node_modules,*/.git
