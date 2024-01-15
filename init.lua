-- vim.cmd [[autocmd BufWritePost init.lua source %]]

require("fns")
vim.g.mapleader = " "

------------------- lazy nvim ---------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-------------------------------------------------------------

------------------- Disabled Plugins -------------------------
local disabled_plugins = {
	-- "nvim-treesitter",
	-- "folke/which-key.nvim",
}
--------------------------------------------------------------

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
	performance = {
		rtp = {
			disabled_plugins = disabled_plugins,
		},
	},
})

require("settings")
require("keybindings")

vim.cmd.colorscheme("catppuccin-frappe")
