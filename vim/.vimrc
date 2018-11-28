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

" Vim-Plug Plugins {{{
"
" Download vim-plug if not already there.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Brief help
" :PlugInstall - installs plugins
" :PlugUpdate  - Update Plugins
" :PlugClean   - confirms removal of unused plugins
" :PlugUpgrade - upgrade vim                        - plug
"

call plug#begin()
" Put your non-Plugin stuff after this line
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " File Explorer
Plug 'jlanzarotta/bufexplorer'                          " Buffer Explorer :BufExplore
Plug 'godlygeek/tabular'                                " Text alignment
Plug 'tpope/vim-fugitive'                               " Git wrapper
Plug 'tpope/vim-sensible'                               " Some default settings
Plug 'vim-airline/vim-airline'                          " Pretty statusbar
Plug 'vim-airline/vim-airline-themes'                   " Pretty statusbar
Plug 'edkolev/promptline.vim'                           " Prompt generator for bash
Plug 'chriskempson/base16-vim'                          " Base-16 theme
Plug 'Townk/vim-autoclose'                              " For auto-close feature
Plug 'w0rp/ale', { 'for' : ['cpp', 'python', 'tex', 'plaintex'] , 'on': 'ALEEnable'}
Plug 'lervag/vimtex', { 'for' : ['tex', 'plaintex'] }
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" All of your Plugins must be added before the following line
call plug#end()


"}}}

" Colors {{{
syntax enable                   " enable syntax processing
let base16colorspace=256        " Access colors present in 256 colorspace
let g:hybrid_use_Xresources = 1
colorscheme base16-ashes " Enable the base16 color scheme

" Transpancey for text and buffer
hi Normal ctermfg=250 ctermbg=none
hi NonText ctermfg=250 ctermbg=none
hi LineNr ctermfg=250 ctermbg=none
hi vertsplit ctermfg=250 ctermbg=none

"}}}

" Tabs {{{
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2  " number of spaces in tab when editing
set shiftwidth=2
set expandtab       " Tabs are spaces
set smarttab        " <BS> removes shiftwidth spaces

" }}}

" Misc {{{
set ttyfast                     " faster redraw
set backspace=indent,eol,start
let g:tex_flavor='latex'        " For laetx filetype
" }}}

" UI {{{
set number         " show line numbers
set showcmd        " show command in bottom bar
set cursorline     " highlight current line
set noshowmode     " do not show mode as airline does that
set wrap           " enable word wrap
set wildmenu       " visual autocomplete for command menu
set lazyredraw     " redraw only when we need to.
set showmatch      " highlight matching [{()}]
set spelllang=en   " spell
set showcmd        " show command on last line of screen
set showmatch      " show bracket matches
set wildmenu       " enhanced cmd line completion
set wildchar=<TAB> " key for line completion
set cc=80          " Right margin
autocmd FileType tex,python,sh,c set tw=75 " Line width
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
nnoremap <leader>e :NERDTreeToggle<CR>

" Forgot sudo??
cmap w!! %!sudo tee  %

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader><Tab> :b#<CR>

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

" Run make
map <f9> :make<CR>
" }}}

" {{{ Autocmds
" Some general autocmd
"
" Clear trailing space while leaving insertmode.
au! BufWritePre %s/\s\+$//e

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
    let g:airline_theme = 'base16_ashes'
endif

" Promptline
" \'b': [ promptline#slices#host(), promptline#slices#user() ],
let g:promptline_preset = {
            \'a': [ promptline#slices#host({ 'only_if_ssh': 1 }) ],
            \'b': [ promptline#slices#conda_env(), promptline#slices#user() ],
            \'c': [ promptline#slices#cwd({ 'dir_limit': 1 }) ],
            \'x': [ promptline#slices#vcs_branch() ],
            \'z': [ promptline#slices#git_status() ]}
            " \'warn' : [ promptline#slices#last_exit_code() ]}
let g:promptline_theme = 'airline'

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_lint_on_enter = 0

let g:ale_set_highlights = 0

let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp' : ['uncrustify'],
\}

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1


" Plugin key-mappings.
let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" vim-tex
let g:vimtex_view_method = 'zathura'

" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files
" polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" forbid gutentags adding gtags databases
let g:gutentags_auto_add_gtags_cscope = 0

" Make CtrlP load faster by making it skip files inside .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" }}}

" vim:foldmethod=marker:foldlevel=0
