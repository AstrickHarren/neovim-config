local U = require "utils"
local cmp = require "cmp"
local opts = require "nvchad.configs.cmp"
local icons = require "icons"

opts.window.completion.scrollbar = true

opts.formatting = {
  fields = { "kind", "abbr", "menu" },
  format = function(_, item)
    local lsp_icons = require "nvchad.icons.lspkind"
    lsp_icons = vim.tbl_extend("force", lsp_icons, icons.lsp_icons)
    local max_menu_len = 50
    item.kind = lsp_icons[item.kind] .. " "

    if item.menu and string.len(item.menu) > max_menu_len then
      item.menu = string.sub(item.menu, 1, max_menu_len) .. "..."
      item.menu = U.string_trim(item.menu)
    end

    return item
  end,
}

opts.mapping = {
  ["<C-k>"] = cmp.mapping.select_prev_item(),
  ["<C-j>"] = cmp.mapping.select_next_item(),
  ["<C-u>"] = cmp.mapping.scroll_docs(-4),
  ["<C-d>"] = cmp.mapping.scroll_docs(4),
  ["<CR>"] = cmp.mapping.confirm {
    behavior = cmp.ConfirmBehavior.Insert,
    select = true,
  },
  ["<C-Space>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.close()
    else
      cmp.complete()
    end
  end),
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif require("luasnip").expand_or_jumpable() then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif require("luasnip").jumpable(-1) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      fallback()
    end
  end, { "i", "s" }),
}

local compare = require "utils.comparators"

opts.sorting = {
  priority_weight = 2,
  comparators = {
    compare.reduce_keywords,
    compare.recently_used,
    -- compare.offset,
    compare.exact,
    compare.score,
    compare.kind,
    compare.length,
    compare.sort_label,
  },
}

cmp.setup(opts)
