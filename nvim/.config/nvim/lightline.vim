" Lightline settings
let g:lightline = {
\ 'colorscheme': 'jellybeans',
\ }

let g:lightline.active = {
\ 'left' : [ [ 'mode', 'paste' ],
\            [ 'filename', 'git', 'diagnostic', 'blame' ],
\          ],
\ 'right': [ [ 'lineinfo' ],
\            [ 'filetype' ],
\            [ 'cocstatus'] ]
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

let g:lightline.component = {
\ 'lineinfo': '%3p%% ☰   %3l:%-2c'
\}

let g:lightline.component_function = {
\ 'filename' : 'LightlineFilename',
\ 'filetype' : 'LightlineFiletype',
\ 'mode'     : 'LightlineMode',
\ 'cocstatus': 'coc#status',
\ 'git'      : 'LightlineGitStatus',
\ 'blame'    : 'LightlineGitBlame',
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
  return winwidth(0) > 70 ? '%3p%% ☰   %3l:%-2c' : '%2p%% : %2l'
endfunction

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : '') : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ &ft == 'qf' ? 'QuickFix' :
        \ winwidth(0) > 70 ? lightline#mode() : ''
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

function! LightlineGitStatus()
  if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler'
    try
      let status = get(g:, 'coc_git_status')
    catch
    endtry
    return status == '0' ? '' : status
  endif
  return ''
endfunction
