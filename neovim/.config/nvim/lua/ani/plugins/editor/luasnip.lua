return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",           -- safe lazy-load trigger
	config = function()
		local ls = require("luasnip")

		ls.config.set_config({
			history = true,
			enable_autosnippets = true,
		})

		local snippets_path = vim.fn.stdpath("config") .. "/lua/ani/snippets"
		-- Use lazy_load so things work when loaded lazily
		require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_path })

		-- If you have legacy module-style snippet files that call ls.add_snippets
		-- and work with `require("ani.snippets.tex.environment")`, you can still require them:
		-- require("ani.snippets.tex.environment")
	end,
}
