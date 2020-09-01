imap <c-x><c-f> <plug>(fzf-complete-path)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>,fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir DAF
    \ call fzf#vim#files('~/GIT/daf',fzf#vim#with_preview(), <bang>0)

command! -bang Ls call fzf#run(fzf#wrap('buffers',
    \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))

" For more of these see :H fzf-vim around line 100
command! B :Buffers
command! C :Commands
command! L :Lines
command! F :Files
command! H :Helptags
command! T :Tags

let g:fzf_buffers_jump=1

nnoremap <leader>f :F<cr>
nnoremap <leader>b :B<cr>
nnoremap <leader>d :DAF<cr>
nnoremap <leader>r :Rg<cr>
" nnoremap <leader>l :L<cr>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'xoffset': 0.5, 'yoffset': 0.5, 'border': 'rounded' }}

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
