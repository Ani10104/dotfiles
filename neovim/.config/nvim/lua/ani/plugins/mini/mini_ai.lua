return {
	"nvim-mini/mini.ai",
	version = false,
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local ai = require("mini.ai")

		ai.setup({
			n_lines = 500, -- how far to look for objects

			-- 🔹 BASIC TEXTOBJECTS (no treesitter)
			custom_textobjects = {
				-- Quotes: vaq / viq
				q = ai.gen_spec.treesitter({
					a = { "@string.outer" },
					i = { "@string.inner" },
				}),

				-- Function: vaf / vif
				f = ai.gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),

				-- Class: vac / vic
				c = ai.gen_spec.treesitter({
					a = "@class.outer",
					i = "@class.inner",
				}),

			},

			search_method = "cover_or_nearest",
		})
	end,
}
