nnoremap <silent> <Leader>gs :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> <Leader>ga :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap          <Leader>gr :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
nnoremap <silent> <Leader>ff :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
let g:fzf_preview_disable_mru = 0
let g:fzf_preview_floating_window_rate = 0.8
let g:fzf_preview_command = 'bat --color=always --plain {-1}'
let g:fzf_preview_default_fzf_options = { '--reverse': v:true, '--preview-window': 'wrap:70%' }
let g:fzf_preview_git_status_preview_command =
	\ "[[ $(git diff --cached -- {-1}) != \"\" ]] && git diff --cached --color=always -- {-1} | delta || " .
	\ "[[ $(git diff -- {-1}) != \"\" ]] && git diff --color=always -- {-1} | delta || " .
	\ g:fzf_preview_command
