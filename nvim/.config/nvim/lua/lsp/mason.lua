local status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("Couldn't load Mason" .. mason, "error")
  return
end

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
  return
end

-- LSP Servers
local servers = {
  "clangd",
  "pyright",
  "lua_ls"
}

mason.setup{}
mason_lspconfig.setup({
  ensure_installed = servers
})
