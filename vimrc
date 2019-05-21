filetype off

augroup sourceVimrc
    au!
    au BufWritePost .vimrc source %
augroup END

"-- Environment Config
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

"-- Plugin Options
    if isdirectory(expand('~/.vim/bundle/Vundle.vim'))
        " Use g:os to pick the rtp and load packages
        if g:os == "LINUX"
            set rtp+=~/.vim/bundle/Vundle.vim
            call vundle#begin()
            Plugin 'jalvesaq/vimcmdline'
            Plugin 'christoomey/vim-tmux-navigator'
            Plugin 'edkolev/tmuxline.vim'
            Plugin 'neoclide/coc.nvim'
            Plugin 'neoclide/vim-node-rpc'
            Plugin 'SirVer/ultisnips'
            Plugin 'honza/vim-snippets'
            Plugin 'unblevable/quick-scope'
        elseif g:os == "WINDOWS"
            set rtp+=$HOME/.vim/bundle/Vundle.vim/
            set rtp+=$HOME/.vim/after

            call vundle#begin('$HOME/.vim/bundle/')
            Plugin 'neoclide/coc.nvim'
            Plugin 'neoclide/vim-node-rpc'
            Plugin 'SirVer/ultisnips'
            Plugin 'honza/vim-snippets'
        else
            set rtp+=~/.vim/bundle/Vundle.vim
            call vundle#begin()
        endif
        Plugin 'VundleVim/Vundle.vim'
        Plugin 'sheerun/vim-wombat-scheme'
        Plugin 'djoshea/vim-matlab-fold'
        Plugin 'junegunn/fzf',{'dir':'~/.fzf','do':'./install --all'}
        Plugin 'markonm/traces.vim'
        Plugin 'justinmk/vim-ipmotion'
        Plugin 'tpope/vim-surround'
        Plugin 'sickill/vim-pasta'
        Plugin 'tomtom/tcomment_vim'
        Plugin 'majutsushi/tagbar'
        Plugin 'w0rp/ale'
        Plugin 'junegunn/fzf.vim'
        Plugin 'itchyny/lightline.vim'
        Plugin 'ntpeters/vim-better-whitespace'
        Plugin 'tpope/vim-fugitive'
        Plugin 'takac/vim-hardtime'
        "Plugin 'vim-latex/vim-latex'
        Plugin 'airblade/vim-rooter'
        Plugin 'vimwiki/vimwiki'
        call vundle#end()

        " :PluginList       - lists configured plugins
        " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
        " :PluginSearch foo - searches for foo; append `!` to refresh local cache
        " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
        " vim +PluginInstall +qall
        so ~/.vim/config/generic_config.vim

        if g:os == "LINUX"
            so ~/.vim/config/linux_config.vim
        elseif g:os == "WINDOWS"
            so ~/.vim/config/windows_config.vim
        endif

    endif

    filetype plugin indent on

    "Fix the matlab plugin stuff so it works in matching
    runtime $VIMRUNTIME/macros/matchit.vim

"-- VIM Options
    syntax on
    set visualbell
    set number
    set relativenumber
    set autoindent
    set ruler
    set wildmenu
    set wildmode=longest:full,full

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

    if version > 810
        " Use patience algorithm for vimdiff
        set diffopt+=algorithm:patience

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

"-- netrw
    let g:netrw_liststyle = 4
    let g:netrw_banner = 0

"-- Mappings
    let mapleader="\\"
    let maplocalleader="\\"

    inoremap <c-s> <Esc>:up<CR>
    nnoremap <c-s> :up<CR>

    " nnoremap <C-H> :TmuxNavigateLeft<CR>
    " nnoremap <C-J> :TmuxNavigateDown<CR>
    " nnoremap <C-K> :TmuxNavigateUp<CR>
    " nnoremap <C-L> :TmuxNavigateRight<CR>
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
    endif

    " Fix up indents so that indenting a block is easy
    xnoremap < <gv
    xnoremap > >gv

    nnoremap <leader>b Oimport ipdb; ipdb.set_trace()  #  BREAKPOINT<ESC>

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

"-- Color Scheme and Status Line
    set laststatus=2
    set noshowmode

    if &runtimepath=~'vim-wombat-scheme' && (g:os == "WINDOWS" || g:os == "LINUX")
        colorscheme wombat
    endif

"-- Commands and Functions
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
