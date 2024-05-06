local M = {}

local function const(x)
  return function()
    return x
  end
end

local function seq(f, g)
  return function()
    f()
    g()
  end
end

local function compose(...)
  local fns = { ... }
  return function(...)
    local ret = fns[1](...)
    for i = 2, #fns do
      ret = fns[i](ret)
    end
    return ret
  end
end

local function lift(f)
  --- @class Applicative
  --- @field eval function
  --- @field of fun(self: Applicative, field: string): Applicative
  --- @field map fun(self: Applicative, g: function): Applicative
  --- @field ap fun(self: Applicative, ...): Applicative
  --- @field apc fun(self: Applicative, ...): Applicative
  --- @field seq fun(self: Applicative, other: Applicative): Applicative
  --- @field only_if fun(self: Applicative, cond: Applicative, otherwise?: Applicative): Applicative
  --- @field eq fun(self: Applicative, value: any): Applicative
  --- @field ne fun(self: Applicative, value: any): Applicative
  --- @field matches fun(self: Applicative, pattern: string): Applicative
  return {
    eval = f,
    map = function(self, g)
      return lift(compose(self.eval, g))
    end,
    of = function(self, field)
      return self:map(function(x)
        return x[field]
      end)
    end,
    ap = function(self, ...)
      local args = { ... }
      return self:map(function(x)
        local args_evaled = {}
        for i, arg in ipairs(args) do
          args_evaled[i] = arg.eval()
        end
        return x(unpack(args_evaled))
      end)
    end,
    apc = function(self, ...)
      local args = { ... }
      return self:map(function(x)
        return x(unpack(args))
      end)
    end,
    seq = function(self, other)
      return lift(seq(self.eval, other.eval))
    end,
    only_if = function(self, cond, otherwise)
      local eval = function(...)
        if cond.eval() then
          self.eval(...)
        elseif otherwise ~= nil then
          otherwise.eval(...)
        end
      end
      return lift(eval)
    end,
    eq = function(self, value)
      return lift(function(...)
        return self.eval(...) == value
      end)
    end,
    ne = function(self, value)
      return lift(function(...)
        return self.eval(...) ~= value
      end)
    end,
    matches = function(self, pattern)
      return lift(function(...)
        local ret = self.eval(...)
        return ret:find(pattern) ~= nil
      end)
    end,
  }
end

M.lift = lift

M.find = function(mod)
  return lift(function()
    return require(mod)
  end)
end

M.vim = lift(const(vim))

M.filetype = M.vim:of("bo"):of "filetype"
M.filename = M.vim:of("fn"):of("expand"):apc "%"

M.const = const
M.nop = function() end
M.feedkeys = function(...)
  return M.vim:of("api"):of("nvim_feedkeys"):apc(..., "n", true)
end

M.vim_cmd = function(cmd)
  return M.vim:of("cmd"):apc(cmd)
end

---------------------- Helpers ----------------------

M.string_trim = function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

M.dbg = function(...)
  print(vim.inspect(...))
end

M.on_filetype = function(mapping)
  return function()
    local filetype = vim.bo.filetype
    local ft_mappings = mapping[filetype] or mapping.default
    return ft_mappings()
  end
end

M.toggle_qf = function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  vim.cmd "botright cw"
end

M.define_lsp_sign = function(icons)
  for key, sign in pairs(icons) do
    key = "DiagnosticSign" .. key
    vim.fn.sign_define(key, { text = sign })
  end
end

M.filter_lsp_by_severity = function()
  -- Create a custom namespace. This will aggregate signs from all other
  -- namespaces and only show the one with the highest severity on a
  -- given line
  local ns = vim.api.nvim_create_namespace "my_namespace"

  -- Get a reference to the original signs handler
  local orig_signs_handler = vim.diagnostic.handlers.signs

  -- Override the built-in signs handler
  vim.diagnostic.handlers.signs = {
    show = function(_, bufnr, _, opts)
      -- Get all diagnostics from the whole buffer rather than just the
      -- diagnostics passed to the handler
      local diagnostics = vim.diagnostic.get(bufnr)

      -- Find the "worst" diagnostic per line
      local max_severity_per_line = {}
      for _, d in pairs(diagnostics) do
        local m = max_severity_per_line[d.lnum]
        if not m or d.severity < m.severity then
          max_severity_per_line[d.lnum] = d
        end
      end

      -- Pass the filtered diagnostics (with our custom namespace) to
      -- the original handler
      local filtered_diagnostics = vim.tbl_values(max_severity_per_line)
      orig_signs_handler.show(ns, bufnr, filtered_diagnostics, opts)
    end,
    hide = function(_, bufnr)
      orig_signs_handler.hide(ns, bufnr)
    end,
  }
end

M.toggle_inlay_hints = function()
  local inlay_hint = vim.lsp.inlay_hint
  inlay_hint.enable(0, not inlay_hint.is_enabled())
end

return M
