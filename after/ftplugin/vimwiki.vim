" Fancy write markdown to PDF for dissemination
nnoremap <leader>w :!pandoc %:p --pdf-engine=xelatex --to=pdf -o ~/%:t:r.pdf<left><left><left><left>
nnoremap <leader>W :!pandoc %:p --pdf-engine=xelatex --to=pdf -o ~/%:t:r.pdf<cr>
