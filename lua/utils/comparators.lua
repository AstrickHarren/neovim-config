local compare = require "cmp.config.compare"
local types = require "cmp.types"
local M = {}

M.reduce_keywords = function(a, b)
  if a:get_kind() == types.lsp.CompletionItemKind.Keyword then
    return false
  end
  if b:get_kind() == types.lsp.CompletionItemKind.Keyword then
    return true
  end
  return nil
end

M.sort_label = function(a, b)
  local diff = vim.stricmp(a.completion_item.label, b.completion_item.label)
  return diff == 0 and nil or diff < 0
end

M.kind = function(entry1, entry2)
  local kind1 = entry1:get_kind() --- @type lsp.CompletionItemKind | number
  local kind2 = entry2:get_kind() --- @type lsp.CompletionItemKind | number
  kind1 = kind1 == types.lsp.CompletionItemKind.Snippet and 1 or kind1
  kind2 = kind2 == types.lsp.CompletionItemKind.Snippet and 1 or kind2

  kind1 = kind1 == types.lsp.CompletionItemKind.Text and 100 or kind1
  kind2 = kind2 == types.lsp.CompletionItemKind.Text and 100 or kind2

  kind1 = kind1 == types.lsp.CompletionItemKind.Keyword and 200 or kind1
  kind2 = kind2 == types.lsp.CompletionItemKind.Keyword and 200 or kind2

  local diff = kind1 - kind2
  return diff == 0 and nil or diff < 0
end

M = vim.tbl_extend("force", compare, M)
return M
