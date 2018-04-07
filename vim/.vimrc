" ~/.vimrc
"
" VIM config file
"
"


" Compability {{{
"
set nocompatible		" use vim defaults instead of vi
set encoding=utf-8		" always encode in utf
filetype off

"}}}

" Vundle Plugins {{{

" Brief help
" :PluginList			- lists configured plugins
" :PluginInstall		- installs plugins
" :PluginUpdate			- Update Plugins
" :PluginSearch foo		- searches for foo; append `!` to refresh local cache
" :PluginClean			- confirms removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" let Vundle manage Vundle, required
	Plugin 'gmarik/Vundle.vim'

	"Put your non-Plugin stuff after this line
	Plugin 'scrooloose/nerdtree'            " File Explorer
	Plugin 'jlanzarotta/bufexplorer'        " Buffer Explorer :BufExplore
	Plugin 'godlygeek/tabular'              " Text alignment
	Plugin 'tpope/vim-fugitive'             " Git wrapper
	Plugin 'tpope/vim-surround'             " Manipulate quotes and brackets
	Plugin 'tpope/vim-sensible'             " Some default settings
	Plugin 'vim-airline/vim-airline'        " Pretty statusbar
	Plugin 'vim-airline/vim-airline-themes' " Pretty statusbar
	Plugin 'edkolev/promptline.vim'         " Prompt generator for bash
    Plugin 'chriskempson/base16-vim'        " Base-16 theme
    Plugin 'Townk/vim-autoclose'            " For auto-close feature
    Plugin 'andviro/flake8-vim'             " Python Syntax check
	Plugin 'terryma/vim-multiple-cursors'   " Multiple cursors work
    Plugin 'sjl/gundo.vim'                  " Visualize undo tree
	" Plugin 'altercation/vim-colors-solarized.git' " Solarized theme
	" Plugin 'Shougo/neocomplete'                   " Automatic keyword completion
	" Plugin 'Shougo/unite.vim'                     " Find files and buffers using ag
	" Plugin 'Shougo/vimfiler.vim'                  " File Explorer :VimFiler
	" Plugin 'majutsushi/tagbar'                    " Display tags in a window
	" Plugin 'scrooloose/syntastic'                 " Syntax checking on write
	" Plugin 'nathanaelkane/vim-indent-guides.git'  " Show tab/space guides


  " All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on      " load filetype-specific indent files, detects filetypes
"}}}

" Colors {{{
syntax enable                   " enable syntax processing
let base16colorspace=256        " Access colors present in 256 colorspace
let g:hybrid_use_Xresources = 1
colorscheme base16-default-dark " Enable the base16 color scheme

" Transpancey for text and buffer
hi Normal ctermfg=250 ctermbg=none
hi NonText ctermfg=250 ctermbg=none
hi LineNr ctermfg=250 ctermbg=none
hi vertsplit ctermfg=250 ctermbg=none

"}}}

" Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4
set expandtab       " Tabs are spaces
set smarttab        " <BS> removes shiftwidth spaces

" }}}

" Misc {{{
set ttyfast                     " faster redraw
set backspace=indent,eol,start
" }}}

" UI {{{
set number         " show line numbers
set showcmd        " show command in bottom bar
set cursorline     " highlight current line
set noshowmode     " do not show mode as airline does that
set nowrap         " disable word wrap
set wildmenu       " visual autocomplete for command menu
set lazyredraw     " redraw only when we need to.
set showmatch      " highlight matching [{()}]
set spelllang=en   " spell
set showcmd        " show command on last line of screen
set showmatch      " show bracket matches
set wildmenu       " enhanced cmd line completion
set wildchar=<TAB> " key for line completion
" }}}

" Searching {{{
set incsearch                            " search as characters are entered
set hlsearch                             " highlight matches
set ignorecase                           " case insensitive searching
set smartcase                            " override ignorecase if upper case typed
set more                                 " Stop in list
" }}}

" Auto-complete {{{
set completeopt=longest,menuone		" Autocompletion options
set complete=.,w,b,u,t,i,d			" autocomplete options (:help 'complete')
" }}}

" Folding {{{
"=== folding ===
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

" Netrw settings {{{
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 25
"
" noremap <silent> <C-e> :Vexplore<CR>
" }}}

" Custom Keymappings {{{
"
" Map leader
" let mapleader = ','

" Turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>

" Remap the split buffer moves
nnoremap <silent> <C-j>  <C-W>j
nnoremap <silent> <C-k>  <C-W>k
nnoremap <silent> <C-h>  <C-W>h
nnoremap <silent> <C-l>  <C-W>l
nnoremap <tab> <C-W>w

" Text selection
nnoremap <S-l> v l
nnoremap <S-h> v h
nnoremap <S-j> <S-v> j
nnoremap <S-k> <S-v> k

" Open file browser
nnoremap <leader>e :NERDTreeFind<CR>

" Forgot sudo??
cmap w!! %!sudo tee  %

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader><Tab> :b#<CR>
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>
nnoremap <M-Right> :bn<CR>
nnoremap <M-Left> :bp<CR>
nnoremap <M-n> :bn<CR>
nnoremap <M-p> :bp<CR>
" Spell checking
nnoremap <leader>s :set spell!<CR>
" Show tabs
nmap <leader>t :set list lcs=tab:+·<CR>
nmap <leader>nt :set nolist<CR>
" Prepare tabularize
nmap <leader>ta :'<,'> Tabularize /
vmap <leader>ta :Tabularize /
" vsplit
nnoremap <leader>v :vsplit<CR>
" Edit .vimrc
nnoremap <leader>vi :e $HOME/.vimrc<CR>
nnoremap <leader>vr :source $HOME/.vimrc<CR>
" Search and delete for trailing spaces and spaces before a tab
nnoremap <leader>dw :%s/\s\+$\\| \+\ze\t//gc<CR>
" Next window
nnoremap <tab> <C-W>w
" Togle fold
nnoremap <space> za
" Search command history
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" Annoying Q, qq, W, ww
cnoremap Q q
cnoremap qq q
cnoremap W w
cnoremap ww w
" }}}

" Plugin configs {{{
"
"  vim-airline
let g:airline_inactive_collapse = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
if has("gui_win32") || &term == "xterm"
"if &term == "xterm"
	let g:airline_powerline_fonts = 0
	let g:airline_symbols = {}
	let g:airline_left_sep = ''
	let g:airline_left_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_sep = ''
	let g:airline_theme = 'base16'
else
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'base16'
endif

" Promptline
" \'b': [ promptline#slices#host(), promptline#slices#user() ],
let g:promptline_preset = {
	\'a': [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
	\'b': [ promptline#slices#conda_env(), promptline#slices#user() ],
	\'c': [ promptline#slices#cwd() ],
	\'x': [ promptline#slices#vcs_branch() ],
	\'z': [ promptline#slices#git_status() ],
	\'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_theme = 'airline'

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1

" }}}

" vim:foldmethod=marker:foldlevel=0
