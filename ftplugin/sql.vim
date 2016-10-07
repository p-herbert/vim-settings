"set makeprg=mysql\ -vvv\ --force\ --comments
" Run MySQL script
""autocmd FileType sql nmap <F1> :w<CR>:make -u PeterHerbert -pM3ch\#2010 < %:r.sql > %:r.lst<CR>

" Run MySQL script
autocmd FileType sql nmap <F1> :w<CR>:!mysql -vvv --force --comments -u PeterHerbert -pM3ch\#2010 < %:r.sql > %:r.lst<CR>

" Switch between the SQL script and spool file
autocmd Bufread *.sql nmap <F2> :e! %:r.lst<CR>
autocmd Bufread *.lst nmap <F2> :e! %:r.sql<CR>

