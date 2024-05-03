local M = {}

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

M.load_plugins = function(repos)
  local plugins = {}
  for i, repo in ipairs(repos) do
    if type(repo) == "string" then
      repo = { repo, config = find_config(repo) }
    elseif type(repo.config) == "string" then
      local config = repo.config
      repo.config = function()
        require("configs." .. config)
      end
    elseif repo.config == nil then
      repo.config = find_config(repo[1])
    end
    plugins[i] = repo
  end
  return plugins
end

return M
