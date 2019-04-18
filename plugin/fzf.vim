command! B :Buffers
command! C :Commands
command! L :Lines
command! F :Files

imap <c-x><c-f> <plug>(fzf-complete-path)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>,fzf#vim#with_preview(), <bang>0)
