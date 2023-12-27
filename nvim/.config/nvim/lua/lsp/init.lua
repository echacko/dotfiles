local status_ok, lspconfig =  pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Couldn't load LSP Config" .. lspconfig, "error")
  return
end

-- Set log level if needed
-- vim.lsp.set_log_level("debug")

lspconfig.lua_ls.setup{}
lspconfig.pyright.setup{}
lspconfig.clangd.setup({
  filetypes = {"c", "cpp"};
  root_dir = require("lspconfig/util").root_pattern("compile_commands.json",
                           "build/compile_commands.json",
                           "compile_flags.txt",
                           ".git");
  cmd = {"clangd", "--background-index", "--pch-storage=memory", "--clang-tidy"};
})

-- Disbale virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false,
  }
)

-- Setup icons & handler helper functions
require('lsp.icons')
require('lsp.handlers')
require('lsp.keymaps')
require('lsp.mason')
