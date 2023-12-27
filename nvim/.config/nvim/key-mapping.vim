" Map leader
" let mapleader = ','

" Disable arrow keys in all mode
inoremap <Up>     <C-o>:echo "--> k <-- "<CR>
inoremap <Down>   <C-o>:echo "--> j <-- "<CR>
inoremap <Right>  <C-o>:echo "--> l <-- "<CR>
inoremap <Left>   <C-o>:echo "--> h <-- "<CR>

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

" Buffer selection
" nnoremap <leader>n :bn<CR>
" nnoremap <leader>p :bp<CR>
nnoremap <leader><Tab> :b#<CR>

" Spell checking
nnoremap <leader>s :set spell!<CR>

" vsplit
nnoremap <leader>vs :vsplit<CR>

" Edit .vimrc
nnoremap <leader>vi :e $HOME/.config/nvim/init.vim <CR>
nnoremap <leader>vr :source $HOME/.config/nvim/init.vim <CR>

" Search and delete for trailing spaces and spaces before a tab
nnoremap <leader>dw :%s/\s\+$\\| \+\ze\t//gc<CR>

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
" map <F2> :mksession! ~/.vim_session<cr>
" And load session with F3
" map <F3> :source ~/.vim_session<cr>
map <F2> :call SaveOrLoadSession()<CR>
function! SaveOrLoadSession()
  if expand('%:t') == ''
    echom "Sourcing session file."
    source ~/.vim_session<CR>
  else
    mksession! ~/.vim_session<CR>
    echom "Created session file."
  endif
endfunction

" Command mode history
cmap <M-p> <up>
cmap <M-n> <down>
cmap <M-k> <up>
cmap <M-j> <down>

" Manually refresh file
" nmap <F5> :e!<cr>

" Helpful delete/change into blackhole buffer
nmap <leader>d "_d
nmap <leader>c "_c

" Copy/paste from clipboard
nnoremap <leader>y "+y
nnoremap <leader>p "+p

" Insert date using F5
:nnoremap <F6> "=strftime("%d/%m/%y %H:%M:%S ")<CR>P
:inoremap <F6> <C-R>=strftime("%d/%m/%y %H:%M:%S ")<CR>

" Tagtree
nnoremap <leader>tt :SymbolsOutline<CR>

" Ident lines
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv<
