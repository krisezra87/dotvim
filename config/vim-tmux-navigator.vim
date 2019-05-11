if (g:os =~? 'LINUX')
    " Do a little magic to keep vim-latex from clobbering <c-j>
    augroup tmuxMovement
        au!
        au VimEnter * nnoremap <c-j> :TmuxNavigateDown<cr>
    augroup END
else
    augroup tmuxMovement
        au!
        au VimEnter * nnoremap <c-j> <c-w>j
    augroup END
endif
