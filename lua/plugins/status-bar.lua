local function copilot()
	return require("copilot_status").status_string()
end

local function mode_fmt(str)
	local icons = require("nvim-nonicons")
	local mode = {
		NORMAL = { icon = icons.get("vim-normal-mode") },
		INSERT = { icon = icons.get("vim-insert-mode") },
		VISUAL = { icon = icons.get("vim-visual-mode") },
		REPLACE = { icon = icons.get("vim-replace-mode") },
		COMMAND = { icon = icons.get("vim-command-mode") },
		TERMINAL = { icon = icons.get("vim-terminal-mode") },
		["V-LINE"] = { icon = icons.get("vim-visual-mode") },
		["V-BLOCK"] = { icon = icons.get("vim-visual-mode") },
	}

	if mode[str] ~= nil then
		return mode[str].icon
	end

	return str:sub(1, 1)
end

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

local config = function()
	local icons = require("nvim-nonicons")
	local file_name = {
		"filename",
		symbols = {
			modified = icons.get("dot-fill"),
			readonly = icons.get("lock"),
		},
	}
	local signs = lsp_signs(icons)
	local diag = {
		"diagnostics",
		symbols = {
			error = signs.error.icon .. " ",
			info = signs.info.icon .. " ",
			warn = signs.warn.icon .. " ",
			hint = signs.hint.icon .. " ",
		},
		colored = true,
	}
	local workspace_diag = vim.tbl_extend("force", diag, {
		sections = { "error", "warn" },
		sources = { "nvim_workspace_diagnostic" },
		diagnostics_color = {
			error = { fg = "#51576e" },
			warn = { fg = "#51576e" },
		},
		-- colored = false,
		always_visible = true,
	})
	local mode = { "mode", fmt = mode_fmt, padding = { right = 3, left = 2 } }
	local branch = { "branch", icon = icons.get("git-compare") }
	local diff = {
		"diff",
		symbols = {
			added = icons.get("diff-added") .. " ",
			modified = icons.get("diff-modified") .. " ",
			removed = icons.get("diff-removed") .. " ",
		},
		source = diff_source,
	}
	local filetype = { "filetype", icon_only = true, padding = { right = 2 } }

	local lsp_progress = {
		function()
			return require("lsp-progress").progress({
				max_size = 80,
			})
		end,
		icon = { "", align = "left" },
		color = { fg = "#51576e" },
	}

	local opts = {
		options = {
			theme = "catppuccin",
			component_separators = "",
			-- section_separators = { right = "", left = "" },
			section_separators = { right = "", left = "" },
			refresh = {
				statusline = 100,
			},
			globalstatus = true,
		},
		extensions = {},
	}
	local location = { "location", padding = { right = 2, left = 1 } }

	opts.sections = {
		lualine_a = { mode },
		lualine_b = { file_name },
		lualine_c = { branch, diag , "%=", workspace_diag },
		lualine_x = { diff, copilot, filetype},
		lualine_y = { "progress" },
		lualine_z = { location, "searchcount" },
	}

	opts.inactive_sections = {
		lualine_a = { file_name },
		lualine_b = {},
		lualine_c = { diag },
		lualine_x = {},
		lualine_y = {},
		lualine_z = { location },
	}

	require("lualine").setup(opts)
end

return {
	{
		"linrongbin16/lsp-progress.nvim",
		enabled = false,
		opts = {
			max_size = 80,
			spinner = spinners().circle_halves,
			series_format = function(title, message, percentage, done)
				local builder = {}
				local has_title = false
				local has_message = false
				if type(title) == "string" and string.len(title) > 0 then
					local escaped_title = title:gsub("%%", "%%%%")
					table.insert(builder, escaped_title)
					has_title = true
				end
				if type(message) == "string" and string.len(message) > 0 then
					local escaped_message = message:gsub("%%", "%%%%")
					table.insert(builder, escaped_message)
					has_message = true
				end
				if percentage and (has_title or has_message) then
					local indication = done and "(✓)" or string.format("(%.0f%%%%)", percentage)
					table.insert(builder, indication)
				end
				return { msg = table.concat(builder, " "), perc = percentage, done = done }
			end,

			client_format = function(client_name, spinner, series_messages)
				-- return #series_messages > 0 and ("[" .. client_name .. "] " .. spinner .. " " .. table.concat(series_messages, ", ")) or nil
				local percs = {}
				local msg = nil

				for _, series_message in ipairs(series_messages) do
					if not series_message.done then
						local perc = series_message.perc
						local perc_msg = perc and string.format("%.0f%%%%", perc) or ""
						table.insert(percs, perc_msg)
					end
					msg = msg or series_message.msg
				end
				-- msg = #series_messages > 1 and msg .. "..." or msg
				msg = client_name .. "" .. spinner .. ": " .. (msg or "")
				local done = #percs == 0

				local perc_msg = client_name .. spinner .. " " .. (done and "✓" or table.concat(percs, " "))
				return { cli = client_name, msg = msg, perc_msg = perc_msg, spinner = spinner, n_jobs = #percs }
			end,

			format = function(client_msgs)
				local msg = nil
				local percs = {}
				local minimal = true

				if #client_msgs == 0 then
					return #vim.lsp.get_active_clients() and "LSP" or nil
				end

				for _, client_msg in ipairs(client_msgs) do
					if msg == nil then
						msg = client_msg.msg
						minimal = client_msg.n_jobs > 1
					else
						minimal = true
					end
					percs[client_msg.cli] = client_msg.perc_msg
				end

				if minimal then
					local ret = {}
					for _, perc in pairs(percs) do
						table.insert(ret, perc)
					end
					return table.concat(ret, " ")
				end

				return msg
			end,
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "yamatsum/nvim-nonicons", "linrongbin16/lsp-progress.nvim" },
		config = config,
	},
}
