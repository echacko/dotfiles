"
"  NeoVIM Configuration File
"
"

" Compability {{{
set nocompatible   " use vim defaults instead of vi
set encoding=utf-8 " always encode in utf
scriptencoding utf-8
filetype off

"}}}

" Plugins {{{
" Download vim-plug if not already there.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-sensible'                               " Some default settings
Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'tpope/vim-surround'                               " All about surroundings
Plug 'Townk/vim-autoclose'                              " For auto-close feature
Plug 'jlanzarotta/bufexplorer'                          " Easily switch buffers
Plug 'luochen1990/rainbow'                              " Make braces colourfull
Plug 'godlygeek/tabular'                                " Text alignment
Plug 'easymotion/vim-easymotion'                        " Easy vim motions

Plug 'majutsushi/tagbar'                                " Display tags in sidebar


Plug 'Shougo/denite.nvim'                               " Fuzzy finder, buffer manager
Plug 'Shougo/neosnippet-snippets'                       " Default snippets def
Plug 'honza/vim-snippets'                               " More snippets def

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'lambdalisue/suda.vim'
Plug 'vimwiki/vimwiki'

" Plugins for file explorer, linter and latex compiler.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'jackguo380/vim-lsp-cxx-highlight'                   " Semanitc highlight

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Color
Plug 'chriskempson/base16-vim'                          " Base-16 theme

call plug#end()

"}}}

" Tabs {{{
set tabstop=2     " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set shiftwidth=2
set expandtab     " Tabs are spaces
set smarttab      " <BS> removes shiftwidth spaces

" }}}

" Misc {{{
set ttyfast                     " faster redraw
set backspace=indent,eol,start
let g:tex_flavor='latex'        " For laetx filetype
set notimeout " Remove timeout for partially typed commands
" Restore last cursor position and marks on open
au BufReadPost *
         \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit' 
         \ |   exe "normal! g`\""
         \ | endif

" Do not load unnecessary plugins
let g:loaded_netrwPlugin = 1    " Disable netrw. We have nerdtree
let g:loaded_2html_plugin = 1   " Never going to use 2html
let g:loaded_zipPlugin = 1      " To see files inside zip archive
let loaded_gzip = 1             " inside gzip archive
let g:loaded_tarPlugin = 1      " tar archive
" let loaded_matchit = 1          " Disable matchit.vim
" let g:loaded_matchparen = 1     " matchparen.vim

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.bmp,*.tiff
set wildignore+=*.pyc
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Close location list or quickfix list if they are present,
" see https://goo.gl/uXncnS
nnoremap<silent> \x :windo lclose <bar> cclose<CR>
" }}}

" Colors {{{
syntax enable                   " enable syntax processing

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif
"
" Theme
let base16colorspace=256        " Access colors present in 256 colorspace
let g:hybrid_use_Xresources = 1
colorscheme base16-gruvbox-dark-soft

" Transpancey for text and buffer
hi Normal ctermfg=250 ctermbg=none
hi NonText ctermfg=250 ctermbg=none
hi LineNr ctermfg=250 ctermbg=none
hi SignColumn ctermfg=250 ctermbg=none
hi vertsplit ctermfg=250 ctermbg=none
" }}}

" UI {{{
set nonumber        " do not show line numbers
set relativenumber  " show number relative to the cursor position
set showcmd         " show command in bottom bar
set cursorline      " highlight current line
set noshowmode      " do not show mode as airline does that
set wrap            " enable word wrap
set wildmenu        " visual autocomplete for command menu
set lazyredraw      " redraw only when we need to.
set showmatch       " highlight matching [{()}]
set spelllang=en    " spell
set wildchar=<TAB>  " key for line completion
set cc=80           " Right margin
set scrolloff=1     " Show atleast one line above/below the cursor
set sidescrolloff=5 " Show at least one line left/right of the cursor.
set matchpairs+=<:> " Highlight matching pairs of brackets
set list            " Show whitespaces
set showtabline=2   " always show tabline
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.
autocmd FileType tex,python,sh,c set tw=75 " Line width
" Substitute live preview
set inccommand=nosplit
set shell=/bin/bash
set fillchars=vert::
set signcolumn=yes  " always show sign column

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" }}}

" Searching {{{
set incsearch                            " search as characters are entered
set hlsearch                             " highlight matches
set ignorecase                           " case insensitive searching
set more                                 " Stop in list
set smartcase                            " override ignorecase if upper case typed
" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END
" }}}

" Folding {{{
set foldmethod=indent " fold based on indent level
set foldnestmax=10    " max 10 depth
set foldenable        " don't fold files by default on open
set foldlevelstart=10 " start with fold level of 1
" }}}

" Vimdiff {{{
if &diff
    set diffopt=filler,foldcolumn:0
endif
" }}}

" Custom Keymappings {{{
"
" Map leader
" let mapleader = ','

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Remap the split buffer moves
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Insert mode movement
imap <M-h> <left>
imap <M-j> <down>
imap <M-k> <up>
imap <M-l> <right>
imap <M-f> <C-right>
imap <M-b> <C-left>


" Resizing
nnoremap <C-M-H> 2<C-w><
nnoremap <C-M-L> 2<C-w>>
nnoremap <C-M-K> <C-w>-
nnoremap <C-M-J> <C-w>+
nnoremap <tab> <C-W>w

" Open file browser
nnoremap <leader>e :NERDTreeToggle<CR>

" Forgot sudo??
" cmap w!! %!sudo tee  %
cnoreabbrev w!! w suda://%

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader><Tab> :b#<CR>

" Spell checking
nnoremap <leader>s :set spell!<CR>

" Prepare tabularize
nmap <leader>ta :'<,'> Tabularize /
vmap <leader>ta :Tabularize /

" vsplit
nnoremap <leader>vs :vsplit<CR>

" Edit .vimrc
nnoremap <leader>vi :e $HOME/.config/nvim/init.vim <CR>
nnoremap <leader>vr :source $HOME/.config/nvim/init.vim <CR>

" Search and delete for trailing spaces and spaces before a tab
nnoremap <leader>dw :%s/\s\+$\\| \+\ze\t//gc<CR>

" Togle fold
nnoremap <space> za

" Toggle Tagbar
nnoremap <leader>tt :TagbarToggle<CR>

" Search command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Annoying Q, qq, W, ww
cnoremap Q q
cnoremap qq q
cnoremap W w
cnoremap ww w

" Run make
map <f9> :make<CR>

" Quick write session with F2
map <F2> :mksession! ~/.vim_session<cr>
" And load session with F3
map <F3> :source ~/.vim_session<cr>

" Command mode history
cmap <M-p> <up>
cmap <M-n> <down>
cmap <M-k> <up>
cmap <M-j> <down>

" Manually refresh file
nmap <F5> :e!<cr>

"}}}

" Pluging Configs {{{
source ~/.config/nvim/plugin-config.vim

" }}}

" vim:foldmethod=marker:foldlevel=0
