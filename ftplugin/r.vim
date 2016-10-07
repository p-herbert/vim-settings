" Execute R Script
autocmd Bufread *.r,*.R nmap <F1> :w<CR>:!Rscript %:r.r<CR>

" Write R script to .Rlog file
autocmd Bufread *.r,*.R nmap <F2> :w<CR>:silent ":!Rscript %:r.r > %:r.Rlog"<CR>:e %:r.Rlog<CR>

" Switch between the .r and .Rlog file
autocmd Bufread *.r,*.R nmap <F3> :e %:r.Rlog<CR>
autocmd Bufread *.Rlog nmap <F3> :e %:r.r<CR>

" Open Rplots
autocmd Bufread *.r,*.R nmap <F4> :!open -a preview Rplots.pdf<CR> 

" R assignment operator
autocmd FileType r iabbrev <buffer> - <-

function! Rhelp(cmd)
   exe ":!Rscript ~/.vim/bin/Rhelp.r" a:cmd 
endfunction
command! -nargs=1 Rhelp :call Rhelp(<f-args>)

" R Settings
autocmd FileType r set tabstop=4 | set shiftwidth=4 | set softtabstop=4 | set smarttab expandtab autoindent | set foldmethod=manual | set foldlevel=20
