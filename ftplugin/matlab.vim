" Vim filetype plugin file
" Language:	matlab
" Maintainer:	Fabrice Guy <fabrice.guy at gmail dot com>
" Last Changed: 2010 May 19

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

augroup matCompiler
    au!
    au BufEnter *.m compiler mlint
augroup END

call matchadd('ErrorMsg','\%>80v.\+')

" Use open windows if possible
nnoremap <c-b> :call REPLSend("dbstop in <c-r>% at <c-r>=line('.')<cr><c-v><cr>")<cr>
nnoremap <c-c> :call REPLSend("dbclear in <c-r>% at <c-r>=line('.')<cr><c-v><cr>")<cr>

let s:save_cpo = &cpo
set cpo-=C

setlocal fo+=croql
setlocal comments=:%>,:%

if exists("loaded_matchit")
  let s:conditionalEnd = '\([-+{\*\:(\/]\s*\)\@<!\<end\>\(\s*[-+}\:\*\/)]\)\@!'
  let b:match_words = '\<classdef\>\|\<methods\>\|\<events\>\|\<properties\>\|\<if\>\|\<while\>\|\<for\>\|\<switch\>\|\<try\>\|\<function\>:' . s:conditionalEnd
endif

setlocal suffixesadd=.m
setlocal suffixes+=.asv
" Change the :browse e filter to primarily show M-files
if has("gui_win32") && !exists("b:browsefilter")
  let  b:browsefilter="M-files (*.m)\t*.m\n" .
	\ "All files (*.*)\t*.*\n"
endif

let b:undo_ftplugin = "setlocal suffixesadd< suffixes< "
      \ . "| unlet! b:browsefilter"
      \ . "| unlet! b:match_words"

let &cpo = s:save_cpo
