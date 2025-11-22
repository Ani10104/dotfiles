return{
	'L3MON4D3/LuaSnip',
	event = { 'BufReadPre', 'BufNewFile' },
	config = function ()
		local ls = require 'luasnip'
		ls.config.set_config({
			history = true, -- keep around last snippet local to jump back
			enable_autosnippets = true,})
		require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
		-- Load globals, aliases, when_in
		-- require("ani.snippets.tex.preamble")

		-- IMPORTANT: Load snippets from your directory
		-- require("luasnip.loaders.from_lua").load({
		-- 	paths = vim.fn.stdpath("config") .. "/lua/ani/snippets"
		-- })
	end
}
