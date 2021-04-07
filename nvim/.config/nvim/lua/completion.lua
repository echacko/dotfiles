local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true, expr = true}

map("i", "<C-n>", "compe#complete()", opts)
map("i", "<CR>",  "compe#confirm('<CR>')", opts)
map("i", "<C-e>", "compe#close('<C-e>')", opts)
map("i", "<C-j>", "compe#scroll({ 'delta': +4 })", opts)
map("i", "<C-k>", "compe#scroll({ 'delta': -4 })", opts)

vim.o.completeopt = "menuone,noselect"

require "compe".setup {
    enabled = true,
    autocomplete = false,
    debug = false,
    min_length = 1,
    preselect = "enable",
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,
    source = {
        path = true,
        buffer = true,
        calc = true,
        vsnip = true,
        nvim_lsp = true,
        nvim_lua = true,
        spell = true,
        tags = true,
        nvim_treesitter = true,
    }
}
