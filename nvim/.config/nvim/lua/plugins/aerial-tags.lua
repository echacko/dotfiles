local aerial = require("aerial")
-- 
-- local function map(bufnr, mode, key, result)
--   vim.api.nvim_buf_set_keymap(bufnr, mode, key, result, { noremap = true, silent = true })
--   print("map", key, result)
-- end
-- 
-- aerial.setup = ({
--   on_attach = function(bufnr)
--     map(bufnr, "n", "<leader>tt", "<cmd>AerialToggle!<CR>")
--   end
-- })

aerial.setup({
  show_guides = true,
    guides = {
    -- When the child item has a sibling below it
    mid_item = "├─",
    -- When the child item is the last in the list
    last_item = "└─",
    -- When there are nested child guides to the right
    nested_top = "│ ",
    -- Raw indentation
    whitespace = "  ",
  },
  on_attach = function(bufnr)
    -- Toggle the aerial window with <leader>a
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>tt', '<cmd>AerialToggle!<CR>', {})
    -- Jump forwards/backwards with '{' and '}'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '{', '<cmd>AerialPrev<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '}', '<cmd>AerialNext<CR>', {})
    -- Jump up the tree with '[[' or ']]'
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '[[', '<cmd>AerialPrevUp<CR>', {})
    vim.api.nvim_buf_set_keymap(bufnr, 'n', ']]', '<cmd>AerialNextUp<CR>', {})
  end
})
