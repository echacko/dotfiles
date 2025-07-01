if not pcall(require, "lspconfig") then
  return
end

-- Taken from https://www.reddit.com/r/neovim/comments/gyb077/nvimlsp_peek_defination_javascript_ttserver/
local M = {}

local _winopts = {
    border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
}

function M.preview_location(location, context, before_context)
  -- location may be LocationLink or Location (more useful for the former)
  context = context or 10
  before_context = before_context or 5
  local uri = location.targetUri or location.uri
  if uri == nil then
    return
  end
  local bufnr = vim.uri_to_bufnr(uri)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    vim.fn.bufload(bufnr)
  end
  local range = location.targetRange or location.range
  local contents =
    vim.api.nvim_buf_get_lines(bufnr, range.start.line - before_context, range["end"].line + 1 + context, false)
  local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
  local _, winnr = vim.lsp.util.open_floating_preview(contents, filetype)
  vim.api.nvim_win_set_config(winnr, _winopts)
  vim.api.nvim_win_set_option(winnr, 'winhighlight', 'Normal:Normal,FloatBorder:FloatBorder')
  vim.api.nvim_win_set_option(winnr, 'cursorline', true)
  vim.api.nvim_win_set_cursor(winnr, {6,1})
  return _, winnr
end

function M.preview_location_callback(_, method, result)
  local context = 10
  if result == nil or vim.tbl_isempty(result) then
    print("No location found: " .. method)
    return nil
  end
  if vim.tbl_islist(result) then
    _G.floating_buf, _G.floating_win = M.preview_location(result[1], context)
  else
    _G.floating_buf, _G.floating_win = M.preview_location(result, context)
  end
end

function M.peek_definition()
  -- workaround for subsequent calls with the popup visuble
  if _G.floating_win ~= nil then
    pcall(vim.api.nvim_win_hide, _G.floating_win)
  end
  if vim.tbl_contains(vim.api.nvim_list_wins(), _G.floating_win) then
    vim.api.nvim_set_current_win(_G.floating_win)
  else
    local params = vim.lsp.util.make_position_params()
    return vim.lsp.buf_request(0, "textDocument/definition", params, M.preview_location_callback)
  end
end

function M.format_range()
  local old_func = vim.go.operatorfunc
  _G.op_func_formatting = function()
    local start = vim.api.nvim_buf_get_mark(0, '[')
    local finish = vim.api.nvim_buf_get_mark(0, ']')
    vim.lsp.buf.range_formatting({}, start, finish)
    vim.go.operatorfunc = old_func
    _G.op_func_formatting = nil
  end
  vim.go.operatorfunc = 'v:lua.op_func_formatting'
  vim.api.nvim_feedkeys('g@', 'n', false)
end

return M
