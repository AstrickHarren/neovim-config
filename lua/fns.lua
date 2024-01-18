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
		hint = { icon = icons.get("question"), hl = "DiagnosticSignHint" },
	}
end
