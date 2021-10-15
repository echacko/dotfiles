if not pcall(require, "lspconfig") then
  return
end

-- Set log level if needed
-- vim.lsp.set_log_level("debug")

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
    client.config.flags.debounce_text_changes  = 150
  end

  local map  =   vim.api.nvim_buf_set_keymap
  local opts = { noremap=true, silent=true }

  map(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- map(bufnr, 'n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts) -- lspsaga
  -- map(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts) -- telescope
  map(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map(bufnr, 'v', 'ga', ':<C-U>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map(bufnr, 'n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map(bufnr, 'n', '<leader>K',  '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map(bufnr, 'n', '<leader>k', '<cmd>lua require("lsp.handlers").peek_definition()<CR>', opts)

  -- https://github.com/glepnir/lspsaga.nvim
  if pcall(require, 'lspsaga') then
      map(bufnr, 'n', 'K',  "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
      map(bufnr, 'n', '<leader>K',  "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
      map(bufnr, 'n', 'ga',  "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
      map(bufnr, 'v', 'ga',  ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)
      map(bufnr, 'n', 'gR',  "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
  end

  map(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map(bufnr, 'n', '[D', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>', opts)
  map(bufnr, 'n', ']D', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>', opts)
  map(bufnr, 'n', '<leader>lc', '<cmd>lua vim.lsp.diagnostic.clear(0)<CR>', opts)
  map(bufnr, 'n', '<leader>lQ', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map(bufnr, 'n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    map(bufnr, 'n', 'gF', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    map(bufnr, "n", "gf", "<cmd>lua require'lsp.handlers'.format_range()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    map(bufnr, 'v', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end

  if client.resolved_capabilities.code_lens then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
    vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
  end
end


-- Configure lua language server for neovim development
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {
        'vim',
        'root',         -- awesomeWM
        'awesome',      -- awesomeWM
        'screen',       -- awesomeWM
        'client',       -- awesomeWM
        'clientkeys',   -- awesomeWM
        'clientbuttons',-- awesomeWM
      },
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
  }
}

-- config that activates keymaps and enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  if pcall(require, 'cmp_nvim_lsp') then
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  end
  return {
    -- enable snippet support
    capabilities = capabilities,
    -- map buffer local keybindings when the language server attaches
    on_attach = on_attach,
  }
end

-- lsp-install
local function setup_servers()
  require'lspinstall'.setup()

  -- get all installed servers
  local servers = require'lspinstall'.installed_servers()
  -- ... and add manually installed servers
  if vim.fn.executable('clangd') == 1 then
    table.insert(servers, "clangd")
  end

  for _, server in pairs(servers) do
    local config = make_config()

    -- language specific config
    if server == "lua" then
      config.settings = lua_settings
    end
    if server == "clangd" then
      config.filetypes = {"c", "cpp"};
      config.root_dir = require("lspconfig/util").root_pattern("compile_commands.json",
                               "build/compile_commands.json",
                               "compile_flags.txt",
                               ".git");
      config.cmd = {"clangd", "--background-index", "--pch-storage=memory", "--clang-tidy"};
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

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
