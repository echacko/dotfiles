--  Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Turn off search highlight
vim.keymap.set('n', '<leader><space>', '<cmd>nohlsearch<CR>', {desc = 'Clear serach highligts'})

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Toggle spell checking
vim.keymap.set('n', '<leader>s', '<cmd>set spell!<CR>', { desc = 'Toggle [s]pell check' })

-- Search and delete for trailing spaces and spaces before a tab
vim.keymap.set('n', '<leader>dw', [[:%s/\s\+$\| \+\ze\t//gc<CR>]], {desc = 'Delete trailing and bad whitespace'})

-- Indent lines in visual mode
vim.keymap.set('v', '<Tab>', '>gv', { desc = 'Indent selected lines' })
vim.keymap.set('v', '<S-Tab>', '<gv', { desc = 'Un-indent selected lines' })
