set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_python_flake8_exec = 'python3'
let g:syntastic_python_flake8_args = ['-m', 'flake8','--ignore=E221,E501,E251']
"let g:syntastic_python_checkers = ['flake8','pep8','python']
let g:syntastic_python_checkers = ['flake8']
