setlocal foldmethod=indent
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix
setlocal encoding=utf-8

" nnoremap <buffer> <F5> :up<cr>:py3file %<cr>
if !exists("b:undo_ftplugin") | let b:undo_ftplugin = '' | endif
let b:undo_ftplugin .= '
    \ | setlocal foldmethod<
    \ | setlocal tabstop<
    \ | setlocal softtabstop<
    \ | setlocal shiftwidth<
    \ | setlocal textwidth<
    \ | setlocal fileformat<
    \ | setlocal encoding<
    \ | setlocal expandtab<
    \ | setlocal autoindent<
    \ '
" \ | nunmap <F5>
