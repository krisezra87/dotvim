" Use markdown instead of vimwiki syntax
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
" help -> "h vimwiki-syntax

let g:vimwiki_global_ext = 0

let core_wiki = {}
let core_wiki.path = '~/.vimwiki/'
let core_wiki.syntax = 'markdown'
let core_wiki.ext = '.md'

" Use .md extension for new links by default
let g:vimwiki_markdown_link_ext = 1

" Prevent write on quit if there are mods
let g:vimwiki_autowriteall = 0

if !empty(glob(expand("~/work_notes/")))
    let work_wiki = {}
    let work_wiki.path = '~/work_notes/'
    let work_wiki.syntax = 'markdown'
    let work_wiki.ext = '.md'
    let g:vimwiki_list = [core_wiki, work_wiki]
else
    let g:vimwiki_list = [core_wiki]
endif
