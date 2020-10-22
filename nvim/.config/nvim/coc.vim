" Coc
" To enable highlight current symbol on CursorHold
set updatetime=100
" autocmd CursorHold  * silent call CocActionAsync('highlight')
" autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

nmap <silent> <leader>cd <Plug>(coc-definition)
nmap <silent> <leader>cy <Plug>(coc-type-definition)
nmap <silent> <leader>cg <Plug>(coc-declaration)
nmap <silent> <leader>cr <Plug>(coc-references)
nmap <silent> <leader>cc :call CocLocations('ccls','$ccls/call')<cr>
nmap <silent> <leader>cC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>
imap <C-l> <Plug>(coc-snippets-expand)
vmap <silent> <leader>cf <Plug>(coc-format-selected)

" remap for complete to use tab and <cr>
" Make <tab> used for trigger completion, completion confirm, snippet expand and jump
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
