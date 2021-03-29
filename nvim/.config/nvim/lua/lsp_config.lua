local nvim_lsp = require("lspconfig")
local nvim_lsp_util = require("lspconfig/util")

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = {noremap = true, silent = true}

-- Mappings.
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>"     , opts)
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>"    , opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>"     , opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" , opts)
map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

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

nvim_lsp.pyls.setup{ on_attach = custom_attach }

nvim_lsp.clangd.setup{
  on_attach = custom_attach,
  default_config = {
    cmd = {
      "clangd", "--background-index", "--pch-storage=memory",
      "--clang-tidy", "--suggest-missing-includes"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    root_dir = nvim_lsp_util.root_pattern("compile_commands.json",
                                 "build/compile_commands.json",
                                 "compile_flags.txt",
                                 ".git"),
    init_option = {
      fallbackFlags = {
        "-std=c++20", "-stdlib=libc++", "-fcoroutines-ts"
      }
    }
  }
}

nvim_lsp.texlab.setup{
  on_attach = custom_attach,
  settings = {
    bibtex = {
      formatting = {
        lineLength = 120
      }
    },
    latex = {
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc", "%f" },
        executable = "latexmk",
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


require'lspconfig'.sumneko_lua.setup {
  on_attach = custom_attach,
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

print("Loaded lsp_config.lua")
