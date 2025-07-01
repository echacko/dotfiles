-- init.lua
-- Here we go agin.
-- Created: June 30 2025

-- Sensible options
-- Map leader key, must happen before plugins are loaded
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

--Disable buildin plugins
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

vim.o.updatetime = 250  -- Decrease update time
vim.o.timeoutlen = 300  -- Decrease mapped sequence wait time
vim.o.confirm = true    -- Always confirm
vim.o.mouse = 'a'       -- Enable mouse
vim.o.undofile = true   -- Save undo history

-- Tabs
vim.o.tabstop = 2      -- number of visual spaces per TAB
vim.o.softtabstop = 2  -- number of spaces in tab when editing
vim.o.shiftwidth = 2   -- number of spaces for auto-indent
vim.o.expandtab = true -- tabs are spaces
vim.o.smarttab = true  -- <BS> removes shiftwidth spaces

-- UI
-- Color
vim.o.termguicolors = true -- enable 24 bit colors

-- Sane UI options
vim.o.number = false            -- do not show line numbers
vim.o.relativenumber = true     -- show number relative to the cursor position
vim.o.showcmd = true            -- show command in bottom bar
vim.o.cursorline = true         -- highlight current line
vim.o.showmode = false          -- do not show mode as airline does that
vim.o.wrap = true               -- enable word wrap
vim.o.wildmenu = true           -- visual autocomplete for command menu
vim.o.lazyredraw = true         -- redraw only when we need to.
vim.o.showmatch = true          -- highlight matching [{()}]
vim.o.spelllang = 'en'          -- spell
vim.o.colorcolumn = '100'       -- Right margin
vim.o.scrolloff = 5             -- Show atleast one line above/below the cursor
vim.o.sidescrolloff = 5         -- Show at least one line left/right of the cursor.
vim.o.list = true               -- Show whitespaces
vim.o.showtabline = 2           -- always show tabline
vim.o.signcolumn = 'number'     -- always show sign column
vim.o.inccommand = 'nosplit'    -- Substitute live preview
vim.opt.matchpairs:append('<:>')-- Highlight matching pairs of brackets

-- Display chars for space, tabs and splits
vim.opt.fillchars = { vert = ':' } -- Use a : for vertical splits
vim.opt.listchars = { tab = '» ', trail = '•', extends = '#',  nbsp = '␣' }

vim.opt.shortmess:append('c') -- Avoid showing message extra message when using completion

-- Format options, see :h fo-table
vim.opt.formatoptions:remove('a') -- No auto format of para
vim.opt.formatoptions:remove('t') -- No auto wrap text using textwidth
vim.opt.formatoptions:append('c') -- Auto wrap comments using tw
vim.opt.formatoptions:append('q') -- Allow formatting using gq
vim.opt.formatoptions:append('r') -- Continue comments after hitting <CR>
vim.opt.formatoptions:remove('o') -- Do not continue comments after hitting o, O

vim.o.breakindent = true          -- Enable break indent

-- Patterns for files and folders to ignore when globbing
local ignore_patterns = {
  '*.o', '*.obj', '*.bin', '*.dll', '*.exe', -- Object and executable files
  '*/.git/*', '*/.svn/*', '*/__pycache__/*', '*/build/**', -- VCS and cache
  '*.jpg', '*.png', '*.jpeg', '*.gif', '*.bmp', '*.tiff', -- Images
  '*.pyc', -- Python cache
  '*.pdf', '*.aux', '*.bbl', '*.blg', '*.brf', '*.fls', '*.fdb_latexmk', '*.synctex.gz', -- LaTeX
}

-- Append each pattern to the wildignore list
for _, pattern in ipairs(ignore_patterns) do
  vim.opt.wildignore:append(pattern)
end


-- Search
vim.o.incsearch = true  -- search as characters are entered
vim.o.hlsearch = true   -- highlight matches
vim.o.ignorecase = true -- case insensitive searching
vim.o.more = true       -- Stop in list
vim.o.smartcase = true  -- override ignorecase if upper case typed
