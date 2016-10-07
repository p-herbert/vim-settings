" Default Python 3
let g:python_version = 3
autocmd BufRead *.py Python3Syntax

" Comment out lines of code
map <S-C> :norm i#<CR>

let g:syntastic_python_checkers = ['flake8']

" Check against PEP 8 Style Guide
""let g:pep8_map='<leader>8'

" Execute Python Script
autocmd BufReadPre *.py nmap <F1> :w<CR>:!python3 %:r.py<CR>

" Write Python script output to .pylog file
autocmd BufRead *.py nmap <F2> :w<CR>:silent ":!python3 %:r.py > %:r.pylog"<CR>:e %:r.pylog<CR>

" Switch between the .py and .pylog files
autocmd Bufread *.py nmap <F3> :e %:r.pylog<CR>
autocmd Bufread *.pylog nmap <F3> :e %:r.py<CR>

" Toggle between Python 2 and Python 3
function! TogglePython()
  let w:python_version3 = exists("w:python_version3") ? !w:python_version3 : 1
  if w:python_version3
    let g:python_version = 2
    Python2Syntax
    nmap <F1> :w<CR>:!python %:r.py<CR>
    nmap <F2> :w<CR>:silent ":!python %:r.py > %:r.pylog"<CR>:e %:r.pylog<CR>
  else
    let g:python_version = 3
    Python3Syntax
    nmap <F1> :w<CR>:!python3 %:r.py<CR>
    nmap <F2> :w<CR>:silent ":!python3 %:r.py > %:r.pylog"<CR>:e %:r.pylog<CR>
  endif
endfunction

" Print current Python compiler version
autocmd Bufread *.py nmap <F4> :echo "Python" g:python_version "compiler is currently set"<CR>

autocmd Bufread *.py nmap <F10> :call TogglePython()<CR><F4>

"Python Settings
autocmd FileType python set tabstop=4 | set shiftwidth=4 | set softtabstop=4 | set smarttab expandtab autoindent | set foldmethod=indent | set foldlevel=20 | let python_highlight_all = 1
autocmd BufWritePre *.py normal m`:%s/\s\+$//e``

let g:pyflakes_use_quickfix = 0

au FileType python set omnifunc=pythoncomplete#Complete

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

set statusline=%{fugitive#statusline()}

map <leader>dt :set makeprg=python\ manage.py\ test\|:call MakeGreen()<CR>

" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>
nmap <silent><Leader>tpj <Esc>:Pytest project<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
