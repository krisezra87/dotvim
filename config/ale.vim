let g:ale_python_flake8_args = ['-m', 'flake8']
let g:ale_python_flake8_options = '--ignore=E221,E501,E251'
" let g:ale_latex_options = '--ignore=W10,W17'
let g:ale_tex_chktex_options = '-n 10,17'

let g:ale_echo_msg_format = '%linter%: %s'
let g:ale_linters = {
    \ 'sh': ['language_server'],
    \ }

let g:ale_fixers = {
\    'tex': [
\        'trim_whitespace',
\        'remove_trailing_lines',
\    ],
\}

let g:ale_fix_on_save = 1
