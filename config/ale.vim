let g:ale_python_flake8_args = ['-m', 'flake8']
let g:ale_python_flake8_options = '--ignore=E221,E501,E251'

let g:ale_linters = {
    \ 'sh': ['language_server'],
    \ }
