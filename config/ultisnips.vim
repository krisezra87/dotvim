" To get Python going, run :py3 print("whatever"), check which python version.
" For Gvim, also try :echo has("win32") to verify 32 bit.  Install matching
" python.  Then running :echo has("python3") should return 1.

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<leader><leader>"
let g:UltiSnipsJumpForwardTrigger="<leader><leader>"
let g:UltiSnipsJumpBackwardTrigger="<leader>p"

"let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
" Let UltiSnipsEdit split the window vertically
let g:UltiSnipsEditSplit="vertical"

call GetEnv()
if g:os == "WINDOWS"
    let g:UltiSnipsUsePythonVersion = 3
    " Note for this to work on gvim for some reason we ned fully qualified
    " path to custom snips
    let g:UltiSnipsSnippetDirectories = ["C:/Users/".$USERNAME."/.vim/UltiSnips","UltiSnips"]
endif
