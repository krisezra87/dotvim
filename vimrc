" VIMRC FILE
" Preamble {{{
augroup sourceVimrc
    au!
    au BufWritePost .vimrc source %
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
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" Plugin Options {{{
    " Use g:os to pick the rtp and load packages
    if g:os == "LINUX"
        call plug#begin('~/.vim/plugged')
        Plug 'jalvesaq/vimcmdline'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'edkolev/tmuxline.vim'
        Plug 'neoclide/coc.nvim'
        Plug 'neoclide/vim-node-rpc'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
        Plug 'unblevable/quick-scope'
        Plug 'wellle/targets.vim'
    elseif g:os == "WINDOWS"
        call plug#begin('~/.vim/plugged')
        set rtp+=$HOME/.vim/after
        Plug 'neoclide/coc.nvim'
        Plug 'neoclide/vim-node-rpc'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'
    else
        call plug#begin('~/.vim/plugged')
    endif
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'sheerun/vim-wombat-scheme'
    Plug 'djoshea/vim-matlab-fold'
    Plug 'junegunn/fzf',{'dir':'~/.fzf','do':'./install --all'}
    Plug 'markonm/traces.vim'
    Plug 'justinmk/vim-ipmotion'
    Plug 'tpope/vim-surround'
    Plug 'sickill/vim-pasta'
    Plug 'tomtom/tcomment_vim'
    Plug 'majutsushi/tagbar'
    Plug 'dense-analysis/ale'
    Plug 'junegunn/fzf.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'tpope/vim-fugitive'
    Plug 'takac/vim-hardtime'
    Plug 'lervag/vimtex'
    Plug 'airblade/vim-rooter'
    Plug 'vimwiki/vimwiki'
    Plug 'mbbill/undotree'
    call plug#end()

    so ~/.vim/config/generic_config.vim

    if g:os == "LINUX"
        so ~/.vim/config/linux_config.vim
    elseif g:os == "WINDOWS"
        so ~/.vim/config/windows_config.vim
    endif

    "Fix the matlab plugin stuff so it works in matching
    runtime $VIMRUNTIME/macros/matchit.vim
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
    " hi clear Conceal doesn't work for some reason

    set tabstop=4
    set shiftwidth=4
    set expandtab

    set ignorecase
    set incsearch

    " Mess with the sign column color
    "highlight clear SignColumn

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
    set ttimeoutlen=50
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
    nnoremap <Space> za

    if version > 740
        tnoremap <C-J> <C-W>j
        tnoremap <C-K> <C-W>k
        tnoremap <C-H> <C-W>h
        tnoremap <C-L> <C-W>l
    endif

    " Fix up indents so that indenting a block is easy
    xnoremap < <gv
    xnoremap > >gv

    iab teh the
    iab waht what
    iab adn and

    " " This is now covered by vim-better-whitespace
    " augroup whitespace
    "     au!
    "     au BufWritePre * %s/\s\+$//e
    " augroup END

    "iab <expr> @today strftime("%y/%m/%d")

    "enable fast sorting
    "xnoremap <leader>s :sort<cr>
" }}}

" Color Scheme and Status Line {{{
    set laststatus=2
    set noshowmode

    if &runtimepath=~'vim-wombat-scheme' && (g:os == "WINDOWS" || g:os == "LINUX")
        colorscheme wombat
    endif
"}}}

" Commands and Functions {{{
    " Make an attempt at smart tab completion from custom function
    "inoremap <tab> <c-r>=Smart_TabComplete()<CR>

    " Navigate the menu with j or k
    " inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
    " inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

    " Vertical Split Buffer Function
    function! VerticalSplitBuffer(buffer)
        execute "vert sb" a:buffer
    endfunction

    " Vertical Split Buffer Mapping
    command! -nargs=1 Vsb call VerticalSplitBuffer(<f-args>)

    " Close other open buffers
    command! Cob :up|%bd|e#|bd#

    " Edit this file
    command! EC :e $MYVIMRC

    command! Grip :!grip -b %

    nnoremap <leader>gr :Grip<CR>

    " Typo fixing
    command! Up :up
    command! Reg :reg

    " Put spaces around equal signs
    command! SpaceAroundEqual :%s/\s\@<!=\+\s\@!/ \0 /g

    " Clear the registers
    command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

    " Allow some cool cat work of files in Vim
    command! -bar Fcat :cd %:p:h | args*.md

    nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
    nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>

    " .mdify a file
    command! Mdify :%s/\(\[\S\+\](\S\+\)\(\S\))/\1\2.md)/ge | :%s/.md.md/.md/ge

    " For more of these see :H fzf-vim around line 100
    command! F :Files
    command! C :Commands
    command! H :Helptags
    command! T :Tags
    command! L :Lines

    command! -bang Ls call fzf#run(fzf#wrap('buffers',
        \ {'source': map(range(1, bufnr('$')), 'bufname(v:val)')}, <bang>0))

    command! Q :q
" }}}

" vim:foldmethod=marker:foldlevel=0
