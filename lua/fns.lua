function map(mode, lhs, rhs, opts)
	local options = {
		noremap = true,
		silent = true,
	}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

function lazy_map(lhs, req, rhs, opt)
	local opt_ = { noremap = true, silent = true }
	if opt then
		opt_ = vim.tbl_extend("force", opt_, opt)
	end

	local mode = type(opt) == "table" and opt.mode or "n"
	opt_.mode = nil

	local req_ = require(req)
	local rhs_ = type(rhs) == "function" and rhs(req_) or req_[rhs]
	vim.keymap.set(mode, lhs, rhs_, opt_)
end

function close_window_checked_alpha()
	local wins = vim.api.nvim_list_wins()
	if #wins == 1 and vim.api.nvim_get_option_value("filetype", {}) ~= "alpha" then
		vim.cmd("Alpha")
	else
		vim.cmd("x")
	end
end

function lsp_signs(icons)
	return {
		error = { icon = icons.get("x-circle"), hl = "DiagnosticSignError" },
		warn = { icon = icons.get("alert"), hl = "DiagnosticSignWarn" },
		info = { icon = icons.get("info"), hl = "DiagnosticSignInfo" },
		hint = { icon = "", hl = "DiagnosticSignHint" },
	}
end

function spinners()
	local arrows = {
		"←",
		"↖",
		"↑",
		"↗",
		"→",
		"↘",
		"↓",
		"↙",
	}

	local two_cols = {
		"⢀⠀",
		"⡀⠀",
		"⠄⠀",
		"⢂⠀",
		"⡂⠀",
		"⠅⠀",
		"⢃⠀",
		"⡃⠀",
		"⠍⠀",
		"⢋⠀",
		"⡋⠀",
		"⠍⠁",
		"⢋⠁",
		"⡋⠁",
		"⠍⠉",
		"⠋⠉",
		"⠋⠉",
		"⠉⠙",
		"⠉⠙",
		"⠉⠩",
		"⠈⢙",
		"⠈⡙",
		"⢈⠩",
		"⡀⢙",
		"⠄⡙",
		"⢂⠩",
		"⡂⢘",
		"⠅⡘",
		"⢃⠨",
		"⡃⢐",
		"⠍⡐",
		"⢋⠠",
		"⡋⢀",
		"⠍⡁",
		"⢋⠁",
		"⡋⠁",
		"⠍⠉",
		"⠋⠉",
		"⠋⠉",
		"⠉⠙",
		"⠉⠙",
		"⠉⠩",
		"⠈⢙",
		"⠈⡙",
		"⠈⠩",
		"⠀⢙",
		"⠀⡙",
		"⠀⠩",
		"⠀⢘",
		"⠀⡘",
		"⠀⠨",
		"⠀⢐",
		"⠀⡐",
		"⠀⠠",
		"⠀⢀",
		"⠀⡀",
	}

	local function with_brackets(spinner)
		local ret = {}
		-- length frame (sometimes lsp-process skips frames)
		local needs_lengthen = #spinner < 8
		for _, v in ipairs(spinner) do
			table.insert(ret, "[" .. v .. "]")
			if needs_lengthen then
				table.insert(ret, "[" .. v .. "]")
			end
		end
		return ret
	end

	local function process(spinners)
		local ret = {}
		for k, v in pairs(spinners) do
			ret[k] = with_brackets(v)
		end
		return ret
	end

	return process({
		arrows = arrows,
		two_cols = two_cols,
		circle_halves = {
			"◐",
			"◓",
			"◑",
			"◒",
		},
	})
end
