local telescope  = require('telescope')
local themes = require("telescope.themes")
local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true}

-- mappings
map("n", "<C-p>",      [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
map("n", "<Leader>ft", [[<Cmd>lua require('telescope.builtin').treesitter()<CR>]], opt)
map("n", "<Leader>fG", [[<Cmd>lua require('telescope.builtin').grep_string()<CR>]], opt)
map("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
map("n", "gr",         [[<Cmd>lua require('telescope.builtin').lsp_references()<CR>]], opt)

telescope.setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "λ ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  sorters.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  sorters.get_generic_fuzzy_sorter,
    path_display= {"absolute"},
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = previewers.buffer_previewer_maker
  },

  -- Config for file picker
  pickers = {
    find_files = {
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
    }
  }
}

