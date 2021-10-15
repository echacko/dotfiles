local dap = require('dap')

local map  =   vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

map("n" , "<F5>       ", "<cmd> lua require'dap'.continue()<CR>", opts)
map("n" , "<F10>      ", "<cmd> lua require'dap'.step_over()<CR>", opts)
map("n" , "<F11>      ", "<cmd> lua require'dap'.step_into()<CR>", opts)
map("n" , "<F12>      ", "<cmd> lua require'dap'.step_out()<CR>", opts)
map("n" , "<leader>b  ", "<cmd> lua require'dap'.toggle_breakpoint()<CR>", opts)
map("n" , "<leader>B  ", "<cmd> lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
map("n" , "<leader>lp ", "<cmd> lua require'dap'.set_breakpoint(nil, nil , vim.fn.input('Log point message : '))<CR>", opts)
map("n" , "<leader>dr ", "<cmd> lua require'dap'.repl.open()<CR>", opts)
map("n" , "<leader>dl ", "<cmd> lua require'dap'.run_last()<CR>", opts)

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = false,
  },
}

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
