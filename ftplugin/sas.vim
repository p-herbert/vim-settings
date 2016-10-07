"Set the fold method
set foldmethod=marker
set foldmarker={{{,}}}

"Only fold if the fold has more than this many lines
set foldminlines=20
set foldnestmax=10

"Set font
set guifont=Lucida_Console:h11:cANSI
command! Tiny set guifont=Lucida_Console:h8:cANSI
command! Small set guifont=Lucida_Console:h11:cANSI
command! Big set guifont=Lucida_Console:h16:cANSI
command! BIG set guifont=Lucida_Console:h24:cANSI

"Visual mode F8 surround selection with /* */
autocmd FileType sas vn <F8> <Esc>`>a */<Esc>`<i/* <Esc>

"Command- to do it blockwise
autocmd FileType sas vn <M-F8> A */<Esc><C-V>`>I/* <Esc>

"Visual mode S-F8 removes /* */ from current visual selection
autocmd FileType sas vn <F9> <Esc>`>F*df/`<f* ldF/

"Check the log for errors
autocmd Bufread *.log nmap <silent> <F10> :vimgrep /\ERROR\<bar>WARNING\<bar>uninitialized\<bar>has 0 observation\<bar>NOTE: No observations\<bar>converted\<bar>Missing values were generated\<bar>Invalid data\<bar>data set with repeats of BY values\<bar>observations with duplicate.*key/ %<CR>:cope<CR>

"Check all logs in current directory for errors
autocmd Bufread *.log nmap <silent> <F11> :lvim /\ERROR\<bar>WARNING\<bar>uninitialized\<bar>has 0 observation\<bar>NOTE: No observations\<bar>converted\<bar>Missing values were generated\<bar>Invalid data\<bar>data set with repeats of BY values\<bar>observations with duplicate.*key/gj *.log<CR>:lw<CR>

"Check the observations in each data set and Table
autocmd Bufread *.log nmap <silent> <F12> :lvim /NOTE:.*observations.*data set\<bar>Table.*rows.*columns/gj *.log<CR>:lw<CR>

"Control-C = insert comment at end of current line
autocmd Filetype sas nmap <C-c> g_a %*;<Left>

"This space-backspace takes care of operating on empty lines (e.g. after O)
autocmd FileType sas imap <C-c> <Space><Backspace><Esc>A%*;<Left>

"Set the SAS compiler
set makeprg=sas.exe\ -nosplash\ -UNBUFLOG\ -sysin\
set errorformat=%f:%:\ %m

"Execute the SAS script
autocmd FileType sas nmap <F1> :w<CR>:make %:r.sas -log  %:r.log -print %:r.lst<CR>

"Switch between the SAS script and log file
autocmd Bufread *.sas nmap <F2> :e %:r.log<CR>
autocmd Bufread *.log nmap <F2> :e %:r.sas<CR>
