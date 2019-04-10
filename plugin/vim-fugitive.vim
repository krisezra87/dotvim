augroup deleteBuffers
    au!
    au BufReadPost fugitive://* set bufhidden=delete
augroup END

" Do some fold magic here for easier navigation with fugitive
command! GH :Gedit HEAD^

" Conflict resolution stuff from https://medium.com/prodopsio/solving-git-merge-conflicts-with-vim-c8a8617e3633
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
