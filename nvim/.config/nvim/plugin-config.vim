" Set python for LSP
let g:python3_host_prog='/usr/bin/python'

" Lightline
source ~/.config/nvim/lightline.vim
" source ~/.config/nvim/icon.vim
" source ~/.config/nvim/statusline.vim

" Denite
" source ~/.config/nvim/denite.vim

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

" vim-tex
let g:vimtex_view_automatic = 1
let g:vimtex_view_automatic_xwin = 1
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_compiler_tectonic = {
    \ 'build_dir' : '',
    \ 'options' : [
    \   '--synctex'
    \ ],
    \}

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

" nvim-lightbulb
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()

" vim-vsnip
" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" Magam-nvim
" nnoremap <silent><expr> <LocalLeader>r  :MagmaEvaluateOperator<CR>
" nnoremap <silent>       <LocalLeader>rr :MagmaEvaluateLine<CR>
" xnoremap <silent>       <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
" nnoremap <silent>       <LocalLeader>rd :MagmaDelete<CR>
" nnoremap <silent>       <LocalLeader>ro :MagmaShowOutput<CR>
" 
" let g:magma_automatically_open_output = v:true
