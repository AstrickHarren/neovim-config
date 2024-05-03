local opts = {
  fast_wrap = {},
  disable_filetype = { "TelescopePrompt", "vim" },
}

require("nvim-autopairs").setup(opts)

-- setup cmp for autopairs
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- setup autopairs for tex-like files
local npairs = require "nvim-autopairs"
local Rule = require "nvim-autopairs.rule"
npairs.setup(opts)
npairs.add_rule(Rule("$", "$", "typst"))
npairs.add_rule(Rule("```", "```", "typst"))
npairs.add_rule(Rule("$", "$", "tex"))
