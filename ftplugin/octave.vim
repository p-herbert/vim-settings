" Execute Octave Script
autocmd BufRead *.m nmap <F1> :w<CR>: !octave %:r.m<CR> 

autocmd BufRead *.oct nmap <F1> :w<CR>: !octave %:r.oct<CR> 
