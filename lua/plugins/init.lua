local M = {
  "stevearc/conform.nvim",
  "neovim/nvim-lspconfig",
  "nvim-telescope/telescope.nvim",
  { "zbirenbaum/copilot.lua", event = "InsertEnter" },
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },
  { "stevearc/dressing.nvim", event = "VeryLazy", config = true },

  -- disabled
  { "folke/which-key.nvim", config = false, enabled = false },
}

-------------------- Loading plugins --------------------
local function find_config(repo)
  repo = repo:match "([^/]+)$"
  repo = repo:match "([^-]+)$"
  if repo:find "%." then
    repo = repo:match "(.+)%..+"
  end
  return function()
    require("configs." .. repo)
  end
end

local function load_plugins(repos)
  local plugins = {}
  for i, repo in ipairs(repos) do
    if type(repo) == "string" then
      repo = { repo, config = find_config(repo) }
    elseif repo.config == nil then
      repo.config = find_config(repo[1])
    end
    plugins[i] = repo
  end
  return plugins
end

return load_plugins(M)
