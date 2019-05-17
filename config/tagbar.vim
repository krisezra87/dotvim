nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_map_help = "<F1>"

let g:tagbar_type_matlab= {
    \ 'ctagstype' : 'MatLab',
    \ 'kinds' : [
    \'c:classes',
    \'f:functions',
    \'v:variables',
    \ ]
    \ }

if g:os == 'WINDOWS'
   let g:tagbar_ctags_bin='$HOME/ctags.exe'
endif
