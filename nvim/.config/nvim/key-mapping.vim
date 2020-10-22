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

" Buffer selection
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
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

" Open NerdTree file browser
nnoremap <leader>e :NERDTreeToggle<CR>

" Toggle Tagbar
nnoremap <leader>tt :Vista!!<CR>

" Tabular
" Prepare tabularize
nmap <leader>ta :'<,'> Tabularize /
vmap <leader>ta :Tabularize /

