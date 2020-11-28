" Lightline settings
let g:lightline = {
\ 'colorscheme': 'nord',
\ }

let g:lightline.active = {
\ 'left' : [ [ 'mode', 'paste' ],
\            [ 'filename', 'git', 'method' ],
\          ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'filetype' ] ]
\ }

let g:lightline.inactive = {
\ 'left' : [ [ 'mode ' ],
\            [ 'filename' ],
\          ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'filetype' ] ]
\ }

let g:lightline.tabline = {
\ 'left':  [ [ 'buffers' ] ],
\ 'right': [ [ ] ]
\}

" let g:lightline.component = {
" \ 'lineinfo': '%3p%% ☰   %3l/%L:%-2c'
" \}

let g:lightline.component_function = {
\ 'lineinfo' : 'LightlineLineNumber',
\ 'filename' : 'LightlineFilename',
\ 'filetype' : 'LightlineFiletype',
\ 'mode'     : 'LightlineMode',
\ 'git'      : 'LightlineGitStatus',
\ 'method'   : 'NearestMethodOrFunction',
\}

let g:lightline.separator = {
\   'left': '', 'right': ''
\}
let g:lightline.subseparator = {
\   'left': '', 'right': '' 
\}

let g:lightline.component_expand = {
\ 'buffers': 'lightline#bufferline#buffers'
\}

let g:lightline.component_type   = {
\ 'buffers': 'tabsel'
\}

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#filename_modifier = ':p:.'
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#number_separator = ' '
let g:lightline#bufferline#number_map = {
  \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
  \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
let g:lightline.tabline_separator = g:lightline.separator
let g:lightline.tabline_subseparator = g:lightline.subseparator


function! LightlineLineNumber()
  let cur = line('.')
  let end = line('$')
  let col = col('.')
  let per = cur * 100 / end
  " printf("%2d%% ☰  %3d/%-3d:%-2d", per, cur, end, col ) :
  return winwidth(0) > 70 ?
    \ printf("%2d%% ☰  %3d:%-2d", per, cur, col ) :
    \ printf("%2d%%", per)
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return  &ft == 'vista_kind' ? 'Vista' :
        \ &ft == 'nerdtree' ? 'NERDTree' :
        \ &ft == 'qf' ? 'QuickFix' :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : '') : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 70 ? lightline#mode() : ''
endfunction

let g:lightline.mode_map = {
    \ 'n' : 'N',
    \ 'i' : 'I',
    \ 'R' : 'R',
    \ 'v' : 'VI',
    \ 'V' : 'VL',
    \ "\<C-v>": 'VB',
    \ 'c' : 'C',
    \ 's' : 'S',
    \ 'S' : 'SL',
    \ "\<C-s>": 'SB',
    \ 't': 'T',
    \ }

function! LightlineGitStatus()
  if expand('%:t') !~? 'vista\|Gundo\|NERD'
    let branch = FugitiveHead()
    let mark = ' '

    return branch !=# '' ? mark.branch : ''
  endif
  return ''
endfunction

" TODO: Maybe use tree-sitter for this?
function! NearestMethodOrFunction() abort
  try
    return get(b:, 'vista_nearest_method_or_function', '')
  catch
  endtry
  return ''
endfunction
