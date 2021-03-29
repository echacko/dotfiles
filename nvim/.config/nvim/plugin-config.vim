" Set python for LSP
let g:python3_host_prog='/usr/bin/python'

" Lightline
source ~/.config/nvim/lightline.vim
" source ~/.config/nvim/icon.vim
" source ~/.config/nvim/statusline.vim

" Denite
source ~/.config/nvim/denite.vim

" CoC-Nvim
" source ~/.config/nvim/nvim-lsp.vim

" NERDTree
" Open NerdTree file browser
nnoremap <leader>e :NERDTreeToggle<CR>

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

" Quick-scope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"VimWiki
let g:vimwiki_list = [{'path': '~/work/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

" Vista
" Toggle tagbar
nnoremap <leader>tt :Vista!!<CR>

let g:vista_default_executive = 'nvim_lsp'      " Specify the LSP
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]      " Nice fonts
let g:vista#renderer#enable_icon = 1            " Show icons
let g:vista_disable_statusline = 1              " disable statusline


" Tabular
" Prepare tabularize
nmap <leader>ta :'<,'> Tabularize /
vmap <leader>ta :Tabularize /

" Doge
let g:doge_doc_standard_python = 'numpy'
