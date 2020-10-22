"  neovim/nvim-lspconfig, nvim-lua/completion-nvim, and nvim-lua/diagnostic-nvim
" https://www.reddit.com/r/neovim/comments/j1nqh2/its_been_a_minute_so_is_coc_the_best_for/g70hwh1/?utm_source=reddit&utm_medium=web2x&context=3
"
" LSP {{{
"
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

nnoremap ]d <cmd>NextDiagnostic<CR>
nnoremap [d <cmd>PrevDiagnostic<CR>

lua <<EOF
local nvim_lsp = require("nvim_lsp")
local nvim_completion = require("completion")
local nvim_diagnostic = require("diagnostic")

local custom_attach = function()
  nvim_completion.on_attach()
  nvim_diagnostic.on_attach()
  print("LSP Attached.")
end

nvim_lsp.pyls.setup{ on_attach = custom_attach }

nvim_lsp.texlab.setup{ on_attach = custom_attach }

nvim_lsp.clangd.setup{ on_attach = custom_attach }
EOF

" }}}
