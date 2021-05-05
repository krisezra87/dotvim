" VIMRC FILE
" Preamble {{{
augroup sourceVimrc
    au!
    au BufWritePost $MYVIMRC nested source $MYVIMRC
    " | PlugUpdate
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | call coc#util#install() | source $MYVIMRC
endif
" }}}

" Environment Config {{{
    " Sets only once the value of g:os to the running environment
    " from romainl
    " https://gist.github.com/romainl/4df4cde3498fada91032858d7af213c2
    function! GetEnv() abort
        if exists('g:os')
            return
        endif
        if has('win64') || has('win32') || has('win16')
            let g:os = 'WINDOWS'
        else
            let g:os = toupper(substitute(system('uname'), '\n', '', ''))
        endif
    endfunction

    call GetEnv()
" }}}

" Plugins {{{
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/vim-plug'
        Plug 'puremourning/vimspector'
        Plug 'ulwlu/elly.vim'
        " Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
        Plug 'tommcdo/vim-exchange'
        Plug 'chrisbra/Colorizer'
        Plug 'SirVer/ultisnips', { 'on': [] }
        Plug 'honza/vim-snippets'
        Plug 'unblevable/quick-scope'
        Plug 'wellle/targets.vim'
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'arzg/vim-colors-xcode'
        Plug 'djoshea/vim-matlab-fold'
        Plug 'junegunn/fzf',{'dir':'~/.fzf','do':'./install --all'}
        Plug 'junegunn/fzf.vim'
        Plug 'tpope/vim-repeat'
        Plug 'tommcdo/vim-lion'
        Plug 'Yggdroot/indentLine'
        Plug 'markonm/traces.vim'
        Plug 'tpope/vim-surround'
        Plug 'sickill/vim-pasta'
        Plug 'tomtom/tcomment_vim'
        Plug 'majutsushi/tagbar'
        Plug 'ntpeters/vim-better-whitespace'
        Plug 'tpope/vim-fugitive'
        Plug 'lervag/vimtex'
        Plug 'airblade/vim-rooter'
        Plug 'vimwiki/vimwiki'
        Plug 'mbbill/undotree'
        Plug 'chaoren/vim-wordmotion'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'neoclide/vim-node-rpc'
        Plug 'tools-life/taskwiki'
        " Plug 'gioele/vim-autoswap'
        " Plug 'sheerun/vim-wombat-scheme'
        " Plug 'junegunn/vim-easy-align'
        " Plug 'nelstrom/vim-visual-star-search'
        " Plug 'pechorin/any-jump.vim'
        " Plug '~/.vim/vim-matlab'
        " Plug 'takac/vim-hardtime'
        " Plug 'justinmk/vim-ipmotion'
        " Plug 'jalvesaq/vimcmdline'
        " Plug 'sheerun/vim-polyglot'
        " Plug 'dense-analysis/ale'
        " Plug 'itchyny/lightline.vim'
        " Plug 'edkolev/tmuxline.vim'
        " Plug 'vifm/vifm.vim'
    call plug#end()

    so ~/.vim/config/generic_config.vim
    so ~/.vim/config/linux_config.vim

    "Fix the matlab plugin stuff so it works in matching
    packadd! matchit
" }}}

" VIM Terminal Config {{{
    nnoremap <leader><space> :botright vert terminal<cr>
    nnoremap <leader>m :LaunchMatlab<cr><c-w>N:set filetype=matlab<cr>i
    augroup terminalStuff
        au!
        au TerminalOpen * let g:last_terminal_id = bufnr("$")
    augroup END
" }}}

" VIM Options {{{
    set visualbell
    set number
    set relativenumber
    set autoindent
    set ruler
    set wildmenu
    set wildmode=longest:full,full
    set conceallevel=2
    set encoding=utf-8
    set shortmess=a
    set history=500
    set cmdheight=2

    set tabstop=4
    set shiftwidth=4
    set expandtab

    set ignorecase
    set incsearch
    set breakindent

    set backupdir=~/.vim/backup//
    set directory=~/.vim/swap//
    set undodir=~/.vim/undo//

    " create line wrapping for comments only.
    set formatoptions-=t

    " Enable hidden buffers
    set hidden

    " Fix backspace behaviors to 'normal'
    set backspace=indent,eol,start

    set diffopt=vertical,context:3,foldcolumn:1,filler

    if version > 800
        " Use patience algorithm for vimdiff
        set diffopt+=algorithm:histogram

        " If we want to use the indent heuristic instead, uncomment this guy
        set diffopt+=indent-heuristic
    endif


    " Additional configs from itscram/dotvim
    set splitright
    set splitbelow
    set autoread
    set wrap
    set si " smart indent
    set smartcase

    set cursorline
    set ttimeout
    set ttimeoutlen=10
    set timeoutlen=500
    set showcmd

    augroup noComment
        au!
        au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    augroup END

    if g:os == "WINDOWS"
        " Configure default window size
        augroup gVimControls
            au!
            au GUIEnter * simalt ~x
        augroup END

        " Set font
        set guifont=Lucida_Console:h12:cANSI:qDRAFT

        " Remove menu bars on gvim
        set guioptions-=m
        set guioptions-=T
        set guioptions-=r
        set guioptions-=R
        set guioptions-=l
        set guioptions-=L
        set guiheadroom=0

        " Setting up ctags stuff
        "set tags=.git/tags
        set notr

    endif

    if has('clipboard')
        if g:os == "WINDOWS"
            set clipboard=unnamed
        elseif g:os == "LINUX"
            set clipboard=unnamedplus
        endif
    endif

    function! NeatFoldText()
        let indent_level = indent(v:foldstart)
        let indent = repeat(' ',indent_level)
        let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = '-' . printf("%10s", lines_count . ' lines') . ' '
        let foldchar = matchstr(&fillchars, 'fold:\zs.')
        let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
        let foldtextend = lines_count_text . repeat(foldchar, 8)
        let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
        return indent . foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
    endfunction
    set foldtext=NeatFoldText()
" }}}

" netrw {{{
    let g:netrw_liststyle = 4
    let g:netrw_banner = 0
" }}}

" Mappings {{{
    let mapleader="\\"
    let maplocalleader="\\"

    let g:netrw_altfile=1

    nnoremap <BS> <C-^>
    nnoremap <C-J> <C-W>j
    nnoremap <C-K> <C-W>k
    nnoremap <C-H> <C-W>h
    nnoremap <C-L> <C-W>l
    nnoremap cp :let @" = expand("%")<cr>

    " Use arrow keys for resizing windows
    nnoremap <Up> <C-W>+
    nnoremap <Down> <C-W>-
    nnoremap <Left> <C-W><
    nnoremap <Right> <C-W>>

    if version > 740
        tnoremap <C-J> <C-W>j
        tnoremap <C-K> <C-W>k
        tnoremap <C-H> <C-W>h
        tnoremap <C-L> <C-W>l
        tnoremap <Esc><Esc> <C-\><C-n>
        tnoremap OD <left>
        tnoremap OC <right>
        tnoremap OA <up>
        tnoremap OB <down>
    endif

    command! -range Gpopupblame call setbufvar(winbufnr(popup_atcursor(systemlist("git -C ".. shellescape(expand('%:p:h')) .." log --no-merges -n 1 -L <line1>,<line2>:" .. shellescape(resolve(expand("%:t")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")

    " Use <Leader>g to show git blame for current line
    nmap <silent><Leader>g :Gpopupblame<CR>

    " Fix up indents so that indenting a block is easy
    xnoremap < <gv
    xnoremap > >gv

    iab teh the
    iab waht what
    iab adn and
" }}}

" Color Scheme and Status Line {{{
    set laststatus=2
    set termguicolors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    " silent! colorscheme xcodewwdc
    silent! colorscheme elly

    " highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr ctermbg=NONE
    highlight VertSplit ctermbg=NONE guibg=NONE
    highlight ColorColumn ctermbg=NONE guibg=NONE
    highlight EndOfBuffer ctermbg=NONE guibg=NONE
    highlight Comment cterm=italic
    highlight CursorLine ctermbg=NONE
    highlight CursorLineNR cterm=bold ctermbg=NONE

    function! SilentGitInfo()
        silent! let l:gitInfo = GitInfo()
        return l:gitInfo
    endfunction

    function! GitInfo()
        let l:longpath = FugitiveGitDir()
        let l:branch = FugitiveHead()
        if empty(l:branch)
          return ''
        endif
        let l:taildir = fnamemodify(l:longpath,':t')
        if l:taildir ==# '.git'
            let l:repo = fnamemodify(l:longpath,':~:h:t')
        else
            " We have just encountered a submodule
            let l:repo = l:taildir
        endif
        return l:repo . ':' . l:branch
    endfunction

    set statusline=
    set statusline+=%#Special#
    set statusline+=\ %{SilentGitInfo()}
    set statusline+=%#LineNr#
    set statusline+=\ %f%r
    set statusline+=%m
    set statusline+=%=
    set statusline+=%#Comment#
    set statusline+=%{&filetype}
    set statusline+=\ \[%{&fileformat}\]
    set statusline+=\ COL:\ %-4c

"}}}

" Commands and Functions {{{
    function! PopulateQF(...)
        let targetfile = a:1
        let content = system('cat ' . targetfile)
        let content = split(content, '\n')
        let list = []
        for curLine in content
            let data = split(curLine, ', ')
            let dict = {'text': data[0], 'filename': data[1], "lnum": data[2]}
            call add(list,dict)
        endfor
        call setqflist(list)
    endfunction

    function! REPLSend(text)
        " Note: send text in double quotes
        call term_sendkeys(g:last_terminal_id, a:text)
    endfunction

    function! REPLEdit(fname,lineNum)
        execute "edit" a:fname
        execute "normal! " . a:lineNum . "G"
        " Rearrange the windows
        execute "only | vert sbprev"
    endfunction

    command! LaunchMatlab :botright vert terminal matlab -nosplash -nodisplay

    " A few convenience things to start
    command! E :e %:h
    command! EC :e $MYVIMRC

    " Typo fixing
    command! Up :up
    command! Reg :reg
    command! Q :q

    " Put spaces around equal signs
    command! SpaceAroundEqual :%s/\s\@<!=\+\s\@!/ \0 /g

    function! NextClosedFold(dir)
        let cmd = 'norm!z' . a:dir
        let view = winsaveview()
        let [l0, l, open] = [0, view.lnum, 1]
        while l != l0 && open
            exe cmd
            let [l0, l] = [l, line('.')]
            let open = foldclosed(l) < 0
        endwhile
        if open
            call winrestview(view)
        endif
    endfunction
    nnoremap <silent> zj :call NextClosedFold('j')<cr>
    nnoremap <silent> zk :call NextClosedFold('k')<cr>

    " There must be a good way to check this
    if 1
        inoremap <expr> <c-x><c-m> fzf#vim#complete(
            \ "rg --files -g '*.m' . ~/GIT/daf \| sed '1d;s:^..::;s/^[^+]*+/+/;s/\\/+/./g;s/^+//;s/\\.m$//;s/\\/@.\\+\\//./;s/\\//./g'")
    else
        inoremap <expr> <c-x><c-m> fzf#vim#complete(
            \ "find . ~/GIT/daf -type f -name '*.m' \| sed '1d;s:^..::;s/^[^+]*+/+/;s/\\/+/./g;s/^+//;s/\\.m$//;s/\\/@.\\+\\//./;s/\\//./g'")
    endif

" }}}

" Zettelkasten {{{
let g:zet_dir = '~/zettel/' "Note that trailing slash is necessary
let g:zet_file_type = '.md' "Note that leading period is necessary

func! ZettelEdit(...)

  " build the file name
  let l:fname = g:zet_dir . strftime("%F-%H%M") . g:zet_file_type

  " edit the new file
  exec "e " . l:fname

  " Need to put the lazy loading code in here
  " enter the title and timestamp (using ultisnips) in the new file
  if len(a:000) > 0
    exec "normal ggO# " . join(a:000) . "\<c-r>=\<c-]>G"
    exec "normal ozetshort\<c-r>=UltiSnipsLazyLoad()\<CR>"
  else
     exec "norm izet\<c-r>=UltiSnipsLazyLoad()\<CR>"
  endif
endfunc

command! -nargs=* Zet call ZettelEdit(<f-args>)

" ztag_complete " should this be a function?
inoremap <expr> <c-x><c-z> fzf#vim#complete(fzf#wrap({'source': 'ztags ' . g:zet_dir}))

function! s:write_fzf(in)
    execute 'normal a' . a:in . ' '
endfunction

command! -bang -nargs=* ZtagInsert call fzf#run({'source': 'ztags ' . g:zet_dir,'sink': function('<sid>write_fzf')})
nnoremap <leader>zt :ZtagInsert<CR>

function! s:tag_lookup(in)
    let l:dirs = substitute(system('zlookup_by_tag -s "' . a:in . '" ' . g:zet_dir), '\^@', '\n', 'g')
    let l:dirs_clean = strtrans(l:dirs)
    execute 'normal a' . substitute(l:dirs_clean,'\^@','\r','g')
endfunction

command! -bang -nargs=* ZtagSearch call fzf#run({'source': 'ztags ' . g:zet_dir,'sink': function('<sid>tag_lookup')})

function! s:ztitle_edit(in)
    let l:parts = split(a:in,' ')
    let l:fname = l:parts[-1]
    exec "e " . l:fname
endfunction

command! -bang -nargs=* ZtitleSearch call fzf#run({'source': 'ztitles ' . g:zet_dir,'sink':function('<sid>ztitle_edit')})
nnoremap <leader>zs :ZtitleSearch<CR>

command! -bang -nargs=* ZLookupEdit call fzf#run({'source': 'zlookup_title_by_tag ' . g:zet_dir,'sink':'e'})

nnoremap <leader>zle :ZLookupEdit<CR>

" Need to do tag search that returns all relevant titles (Might be that the shell functions give us that.  zlookup_by_tag as a follow to fzf tag search

" Need a general search function which does both keyword searching inside of notes.  Conveniently, the title is inside the note body anyway.

" Need to tune up paths for matlab biz above

" }}}

" vim:foldmethod=marker:foldlevel=0
