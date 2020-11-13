"  neovim/nvim-lspconfig, nvim-lua/completion-nvim, and nvim-lua/diagnostic-nvim
" https://www.reddit.com/r/neovim/comments/j1nqh2/its_been_a_minute_so_is_coc_the_best_for/g70hwh1/?utm_source=reddit&utm_medium=web2x&context=3
"
" LSP {{{
"
" TODO: Add snippets completion and telescope
" TODO: Split to lua files and seperate files for each plugins
" Which python to use for LSP
let g:python3_host_prog='/usr/bin/python'

nnoremap <silent> cd        <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> cg        <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K         <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD        <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
inoremap <silent> <C-s>     <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD       <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr        <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0        <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW        <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> ge        <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
nnoremap <silent> ga        <cmd>lua vim.lsp.buf.code_action()<CR>

nnoremap <silent> <leader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f <cmd>lua vim.lsp.buf.formatting()<CR>

let g:diagnostic_enable_virtual_text = 1      " Show msg at eol
let g:diagnostic_trimmed_virtual_text = '20'  " Lenght of msg
let g:diagnostic_insert_delay = 1             " Do not show msg while in INS
let g:diagnostic_virtual_text_prefix = ' '
call sign_define("LspDiagnosticsErrorSign", {"text" : "✗", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "!!", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "--", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "~~", "texthl" : "LspDiagnosticsHint"})
nnoremap ]d <cmd>NextDiagnosticCycle<CR>
nnoremap [d <cmd>PrevDiagnosticCycle<CR>

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_enable_auto_signature = 0      " Disable signature preview
let g:completion_enable_snippet = "Neosnippet"  " For snippet support. TODO

" Configure the completion chains
let g:completion_chain_complete_list = {
      \'default' : {
      \ 'default' : [
      \   {'complete_items' : ['lsp', 'snippet']},
      \   {'mode' : 'file'}
      \ ],
      \ 'comment' : [],
      \ 'string' : []
      \ },
      \'vim' : [
      \ {'complete_items': ['snippet']},
      \ {'mode' : 'cmd'}
      \ ],
      \'c' : [
      \ {'complete_items': ['ts']}
      \ ],
      \'python' : [
      \ {'complete_items': ['snippet', 'ts']}
      \ ],
      \'lua' : [
      \ {'complete_items': ['ts']}
      \ ],
      \}

lua <<EOF
local nvim_lsp = require("nvim_lsp")
local nvim_completion = require("completion")
local nvim_diagnostic = require("diagnostic")
local nvim_treesitter = require("nvim-treesitter.configs")

local custom_attach = function()
  nvim_completion.on_attach()
  nvim_diagnostic.on_attach()
  print("LSP Attached.")
end

nvim_lsp.pyls.setup{ on_attach = custom_attach }

nvim_lsp.texlab.setup{ on_attach = custom_attach }

nvim_lsp.clangd.setup{ on_attach = custom_attach }

nvim_treesitter.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
}

EOF
" }}}
