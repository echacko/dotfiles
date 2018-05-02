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

" Function to install YCM
function! BuildYCM(info)
    " info is a dictionary with 3 fields
    " - name:   name of the plugin
    " - status: 'installed', 'updated', or 'unchanged'
    " - force:  set on PlugInstall! or PlugUpdate!
    if a:info.status == 'installed' || a:info.force
        !./install.py
    endif
endfunction

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
Plug 'andviro/flake8-vim', { 'for' : 'python' }         " Python Syntax check
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM'), 'on': []}
Plug 'maralla/completor.vim', { 'on': [] }
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'honza/vim-snippets', { 'on': [] }
Plug 'ervandew/supertab', { 'on': [] }
" All of your Plugins must be added before the following line
call plug#end()

" Autocmd to load YCM and ultisnips
augroup load_us_ycm
    autocmd!
    autocmd InsertEnter *.py call plug#load('completor.vim', 'supertab')
    autocmd InsertEnter *.py call plug#load('ultisnips', 'vim-snippets')
    " autocmd! load_us_ycm
augroup END

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

" }}}

" {{{ Autocmds
" Some general autocmd
"
" Clear trailing space while leaving insertmode.
au! InsertLeave %s/\s\+$//e

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

" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<Tab>"
let g:UltiSnipsJumpForwardTrigger = "<Tab>"
let g:UltiSnipsJumpBackwardTrigger = "<S-Tab>"

" completor
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" Prevent auto trigger of complete
"let g:completor_auto_trigger = 0
"inoremap <expr> <Tab> pumvisible() ? "<C-N>" : "<C-R>=completor#do('complete')<CR>"
let g:completor_min_chars = 2

" }}}

" vim:foldmethod=marker:foldlevel=0
