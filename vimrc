" VIMRC FILE
" Preamble {{{
augroup sourceVimrc
    au!
    au BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END
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

" vim-plug install {{{
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | call coc#util#install() | source $MYVIMRC
endif
" }}}

" Plugin Options {{{
    call plug#begin('~/.vim/plugged')
        Plug 'junegunn/vim-plug'
        Plug 'SirVer/ultisnips', { 'on': [] }
        Plug 'honza/vim-snippets'
        Plug 'unblevable/quick-scope'
        Plug 'wellle/targets.vim'
        Plug 'michaeljsmith/vim-indent-object'
        Plug 'sheerun/vim-wombat-scheme'
        Plug 'djoshea/vim-matlab-fold'
        Plug 'junegunn/fzf',{'dir':'~/.fzf','do':'./install --all'}
        Plug 'junegunn/fzf.vim'
        Plug 'nelstrom/vim-visual-star-search'
        Plug 'tpope/vim-repeat'
        Plug 'tommcdo/vim-lion'
        Plug 'Yggdroot/indentLine'
        Plug 'markonm/traces.vim'
        Plug 'tpope/vim-surround'
        Plug 'sickill/vim-pasta'
        Plug 'tomtom/tcomment_vim'
        Plug 'majutsushi/tagbar'
        Plug 'dense-analysis/ale'
        Plug 'itchyny/lightline.vim'
        Plug 'ntpeters/vim-better-whitespace'
        Plug 'tpope/vim-fugitive'
        Plug 'lervag/vimtex'
        Plug 'airblade/vim-rooter'
        Plug 'vimwiki/vimwiki'
        Plug 'mbbill/undotree'
        " Plug 'chaoren/vim-wordmotion'
        " Plug '~/.vim/vim-matlab'
        " Plug 'takac/vim-hardtime'
        " Plug 'justinmk/vim-ipmotion'
        " Plug 'jalvesaq/vimcmdline'
        " Plug 'sheerun/vim-polyglot'
        " Plug 'christoomey/vim-tmux-navigator'
        " Plug 'edkolev/tmuxline.vim'
        " Plug 'vifm/vifm.vim'
        Plug 'neoclide/coc.nvim', {'branch': 'release'}
        Plug 'neoclide/vim-node-rpc'
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
    set history=500

    set tabstop=4
    set shiftwidth=4
    set expandtab

    set ignorecase
    set incsearch
    set breakindent

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

    " Fix up indents so that indenting a block is easy
    xnoremap < <gv
    xnoremap > >gv

    iab teh the
    iab waht what
    iab adn and
" }}}

" Color Scheme and Status Line {{{
    set laststatus=2
    set noshowmode

    if &runtimepath=~'vim-wombat-scheme' && (g:os == "WINDOWS" || g:os == "LINUX")
        colorscheme wombat
    endif

    " Add customized transparency
    highlight CursorLineNr term=bold cterm=bold ctermfg=173 gui=bold
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr ctermbg=NONE
    set colorcolumn=81
    " Disable the vertical split bar if necessary
    highlight VertSplit ctermbg=NONE guibg=NONE
    " call matchadd('ErrorMsg','\%>80v.\+')
    highlight ColorColumn ctermbg=NONE
    highlight CursorLine ctermbg=234
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

    " Helper functions
    " Vertical Split Buffer Mapping
    command! -nargs=1 Vsb call VerticalSplitBuffer(<f-args>)
    function! VerticalSplitBuffer(buffer)
        execute "vert sb" a:buffer
    endfunction

    " Execute grip on an md file
    command! Grip :!grip -b %
    nnoremap <leader>gr :Grip<CR>

    " Put spaces around equal signs
    command! SpaceAroundEqual :%s/\s\@<!=\+\s\@!/ \0 /g

    " Clear the registers
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

    " Allow some cool cat work of files in Vim
    command! -bar Fcat :cd %:p:h | args*.md

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

    " .mdify a file
    command! Mdify :%s/\(\[\S\+\](\S\+\)\(\S\))/\1\2.md)/ge | :%s/.md.md/.md/ge
" Close buffer (without closing window)
    nnoremap <expr><leader>d len(getbufinfo("")[0].windows) > 1 ?
        \ ":close<CR>" :
        \ (bufnr("") == getbufinfo({"buflisted": 1})[-1].bufnr ? ":bp" : ":bn")."<bar>bd #<CR>"

" inoremap <expr> <c-x><c-f> fzf#vim#complete#path(
"     \ "find . -path '*/\.*' -prune -o -print \| sed '1d;s:^..::'",
"     \ fzf#wrap({'dir': expand('%:p:h')}))

inoremap <expr> <c-x><c-m> fzf#vim#complete(
    \ "find . -type f \\( -name '*.m' \\) -print \| sed '1d;s:^..::;s/\\/+/./g;s/^+//;s/\\.m$//;s/\\/@.\\+\\//./;s/\\//./g'")

command! Matify :s/\/+/./g|s/^+//|s/\.m$//|s/\/@.\+\//./|s/\//./g
" }}}

" vim:foldmethod=marker:foldlevel=0
