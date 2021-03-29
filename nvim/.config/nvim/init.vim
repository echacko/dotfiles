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
" Plug 'jiangmiao/auto-pairs'
Plug 'luochen1990/rainbow'                              " Make braces colourful
Plug 'godlygeek/tabular'                                " Text alignment
Plug 'liuchengxu/vista.vim'                             " Tag bar
Plug 'unblevable/quick-scope'                           " highlights for f,F

Plug 'Shougo/denite.nvim'                               " Fuzzy finder, buffer manager

" Snippets
Plug 'norcalli/snippets.nvim'                           " Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'                       " Default snippets def
Plug 'honza/vim-snippets'                               " More snippets def
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Document genration
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Plugins for file explorer, linter and latex compiler.
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'vimwiki/vimwiki'
Plug 'plasticboy/vim-markdown'                     " Markdown

" Plugins for file explorer, linter and latex compiler.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Language server plugins
Plug 'neovim/nvim-lspconfig'    " NVim LSP client
Plug 'nvim-lua/lsp-status.nvim' " generate status line components using LSP

Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/completion-nvim' " Auto-completion
Plug 'kosayoda/nvim-lightbulb'  " code-action

Plug 'nvim-treesitter/nvim-treesitter'             " nvim treesiter
" Plug 'nvim-treesitter/completion-treesitter'       " completion srcs
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Color
Plug 'chriskempson/base16-vim'
Plug 'joshdick/onedark.vim'
Plug 'tjdevries/colorbuddy.vim'
Plug 'Th3Whit3Wolf/onebuddy'

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
" let loaded_matchit = 1          " Disable matchit.vim let
" g:loaded_matchparen = 1     " matchparen.vim

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.jpg,*.png,*.jpeg,*.gif,*.bmp,*.tiff
set wildignore+=*.pyc
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

" Format options, see :h fo-table
set formatoptions-=a    " No auto format of para
set formatoptions-=t    " No auto wrap text using textwidth
set formatoptions+=c    " Auto wrap comments using tw
set formatoptions+=q    " Allow formatting using gq
set formatoptions-=o    " Do not continue comments after hitting o, O
set formatoptions+=r    " Continue comments after hitting <CR>

" Close location list or quickfix list if they are present, see
" https://goo.gl/uXncnS
nnoremap<silent> \x :windo lclose <bar> cclose<CR>

if has('nvim') && executable('nvr')
  let $GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
" }}}

" Colors {{{
syntax enable                   " enable syntax processing

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=256
endif

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors            " Enables 24-bit RGB color in the terminal
endif

"
" Theme
let base16colorspace=256        " enable if using base16-shell
let g:hybrid_use_Xresources = 1
colorscheme onedark
" let g:sonokai_style = 'andromeda'


" Transpancey for text and buffer
hi Normal ctermfg=250 ctermbg=none
hi NonText ctermfg=250 ctermbg=none
hi LineNr ctermfg=250 ctermbg=none
" hi SignColumn ctermfg=250 ctermbg=none
hi vertsplit ctermfg=250 ctermbg=none
" }}}

" UI {{{
set nonumber           " do not show line numbers
set relativenumber     " show number relative to the cursor position
set showcmd            " show command in bottom bar
set cursorline         " highlight current line
set noshowmode         " do not show mode as airline does that
set wrap               " enable word wrap
set wildmenu           " visual autocomplete for command menu
set lazyredraw         " redraw only when we need to.
set showmatch          " highlight matching [{()}]
set spelllang=en       " spell
set wildchar=<TAB>     " key for line completion
set cc=80              " Right margin
set scrolloff=1        " Show atleast one line above/below the cursor
set sidescrolloff=5    " Show at least one line left/right of the cursor.
set matchpairs+=<:>    " Highlight matching pairs of brackets
set list               " Show whitespaces
set showtabline=2      " always show tabline
set signcolumn=number  " always show sign column
set inccommand=nosplit " Substitute live preview
set shell=/bin/bash    " Default shell

" Display chars for space, tabs and splits
set fillchars=vert::
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c

autocmd FileType tex,python,sh,c set tw=75 " Line width
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
source ~/.config/nvim/key-mapping.vim
"}}}

" Pluging Configs {{{
source ~/.config/nvim/plugin-config.vim
lua require 'init'

" }}}

" vim:foldmethod=marker:foldlevel=0
