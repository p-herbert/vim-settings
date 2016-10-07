" Execute Perl Script
autocmd BufReadPre *.pl nmap <F1> :w<CR>:!perl %:r.pl<CR>
