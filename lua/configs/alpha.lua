local art = {}

local function alpha_on_enter_redraw_plugins(dashboard)
  vim.api.nvim_create_autocmd("User", {
    group = vim.api.nvim_create_augroup("AlphaStats", { clear = false }),
    pattern = "AlphaReady",
    callback = function()
      local stats = require("lazy").stats()
      local footer_val =
        string.format("󱐋 %d/%d plugins loaded in %.4f ms", stats.loaded, stats.count, stats.times.LazyDone)
      dashboard.section.footer.val = footer_val
      pcall(vim.cmd.AlphaRedraw)
    end,
  })
end

local dashboard = require "alpha.themes.dashboard"
-- dashboard.section.header.val = art
dashboard.section.buttons.val = {
  -- dashboard.button("l", "󰋚  Load Last Session", "<cmd>NeovimProjectLoadRecent<CR>"),
  dashboard.button("l", "  Open Lazy", "<cmd>Lazy<CR>"),
  dashboard.button("c", "  Settings", "<cmd>silent cd $HOME/.config/nvim | e $MYVIMRC<CR>"),
  dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

require("alpha").setup(dashboard.config)
alpha_on_enter_redraw_plugins(dashboard)
