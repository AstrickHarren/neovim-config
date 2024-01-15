return {
	{
		"windwp/nvim-autopairs",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			check_ts = true,
			rust = {},
		},
		config = function(_, opts)
			local npairs = require("nvim-autopairs")
			npairs.setup(opts)
			local Rule = require("nvim-autopairs.rule")
			local ts_conds = require("nvim-autopairs.ts-conds")

			local rule = Rule("|", "|", "rust"):with_pair(
				ts_conds.is_not_ts_node({ "block_comment", "string_literal", "line_comment" }),
				ts_conds.is_endwise_node({ "line_comment" })
			)
			npairs.add_rule(rule)
		end,
	},
}
