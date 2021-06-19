local nvim_lsp = require("lspconfig")
local nvim_lsp_util = require("lspconfig/util")

-- Set log level if needed
-- vim.lsp.set_log_level("debug")

local map  =   vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

local function preview_location_callback(_, _, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

-- Mappings.
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
-- map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- telescope
-- map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

map("n", "ga", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
map("n", "gf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
map("n", "gA", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gF", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

-- map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "K", "<cmd>lua PeekDefinition()<CR>", opts)
map("n", "<C-K>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
map("n", "<space>e",  "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
map("n", "<leader>D", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

-- Define LSP diagnostic signs
vim.fn.sign_define("LspDiagnosticsSignError",
  {text = "✗", texthl="LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
  {text = "!", texthl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
  {text = "I", texthl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
  {text = "H", texthl = "LspDiagnosticsDefaultHint"})

local custom_attach = function()
  print("LSP Attached.")
end

-- LSP snippet completion support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


-- LSP server configs
-- Python
nvim_lsp.pyls.setup{ on_attach = custom_attach, capabilities = capabilities }

-- C/C++
nvim_lsp.clangd.setup{
  on_attach = custom_attach,
  capabilities = capabilities,
  root_dir = nvim_lsp_util.root_pattern("compile_commands.json",
                               "build/compile_commands.json",
                               "compile_flags.txt",
                               ".git"),
  cmd = {
    "clangd", "--background-index", "--pch-storage=memory",
    "--clang-tidy"
  },
  -- default_config = {
  --   log_level = 2,
  --   init_option = {
  --     fallbackFlags = {
  --       "-std=c++20", "-stdlib=libc++", "-fcoroutines-ts"
  --     }
  --   }
  -- }
}

-- LaTeX
nvim_lsp.texlab.setup{
  on_attach = custom_attach,
  capabilities = capabilities,
  settings = {
    bibtex = {
      formatting = {
        lineLength = 120
      }
    },
    latex = {
      build = {
        -- args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc", "%f" },
        args = {"%f", "--synctex", "--keep-logs", "--keep-intermediates"},
        executable = "tectonic",
        onSave = true
      },
      forwardSearch = {
        executable = "zathura",
        args = {"--synctex-forward", "%l:1:%f", "%p"},
        onSave = true
      },
      lint = {
        onChange = true
      }
    }
  }
}

-- Lua
require'lspconfig'.sumneko_lua.setup {
  on_attach = custom_attach,
  capabilities = capabilities,
  cmd = {
    "lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"
  },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most
        -- likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false,
  }
)
