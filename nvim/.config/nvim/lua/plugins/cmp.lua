local cmp = require("cmp")
local lspkind = require("lspkind")

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0
--     and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(
--       col, col):match("%s") == nil
-- end
-- 
-- local feedkey = function(key, mode)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
--     mode, true)
-- end

lspkind.init({
  symbol_map = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "塞",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = ""
  }
})

cmp.setup({
  completion = {
    autocomplete = false,
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  sources = {
    { name = 'copilot'},
    { name = 'nvim_lsp', keywork_length = 3, max_item_count = 5 },
    { name = 'buffer' },
    { name = 'vsnip' },
    { name = 'path' },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = false,
      maxwidth = 50,
      menu = {
        buffer = "BUF",
        nvim_lsp = "LSP",
        path = "PATH",
        vsnip = "SNIP",
      }
    }
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  -- mapping = {
  --   ["<C-p>"] = cmp.mapping.select_prev_item(),
  --   ["<C-n>"] = cmp.mapping.select_next_item(),
  --   ["<C-d>"] = cmp.mapping.scroll_docs(-4),
  --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
  --   ["<C-Space>"] = cmp.mapping.complete(),
  --   ["<C-e>"] = cmp.mapping.close(),
  --   ["<CR>"] = cmp.mapping.confirm {
  --     behavior = cmp.ConfirmBehavior.Replace,
  --     select = false
  --   },
  --   ["<Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_next_item()
  --     elseif vim.fn["vsnip#available"](1) == 1 then
  --       feedkey("<Plug>(vsnip-expand-or-jump)", "")
  --     elseif has_words_before() then
  --       cmp.complete()
  --     else
  --       local copilot_keys = vim.fn["copilot#Accept"]()
  --       if copilot_keys ~= "" then
  --         vim.api.nvim_feedkeys(copilot_keys, "i", true)
  --       else
  --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  --       end
  --     end
  --   end, {"i", "s"}),
  --   ["<S-Tab>"] = cmp.mapping(function()
  --     if cmp.visible() then
  --       cmp.select_prev_item()
  --     elseif vim.fn["vsnip#jumpable"](-1) == 1 then
  --       feedkey("<Plug>(vsnip-jump-prev)", "")
  --     end
  --   end, {"i", "s"})
  -- }
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
