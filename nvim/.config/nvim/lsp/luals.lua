return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      -- diagnostics = {
      --   -- Add 'vim' to the list of recognized globals
      --   globals = { 'vim' },
      -- },
      workspace = {
        -- Make the server aware of Neovim's library files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    }
  }
}
