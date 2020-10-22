" Set python for LSP
let g:python3_host_prog='/usr/bin/python'

" Lightline
source ~/.config/nvim/lightline.vim

" Denite
source ~/.config/nvim/denite.vim

" CoC-Nvim
source ~/.config/nvim/coc.vim

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
" Hide the Nerdtree status line to avoid clutter
let g:NERDTreeStatusline = ''
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1
" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Rainbow Braces
let g:rainbow_active = 1

" Easymotion
"   <leader>w - Easy-motion highlights first word letters bi-directionally
map <leader>f <Plug>(easymotion-bd-w)

"VimWiki
let g:vimwiki_list = [{'path': '~/work/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
