return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	config = function()
		local ls = require("luasnip")

		------------------------------------------------------------------
		-- LuaSnip core config
		------------------------------------------------------------------
		ls.config.set_config({
			history = true,
			enable_autosnippets = true,
			store_selection_keys = "<Tab>",
			update_events = "TextChanged,TextChangedI",
		})

		------------------------------------------------------------------
		-- Keymaps (LuaSnip-only logic lives here)
		------------------------------------------------------------------

		-- Jump forward
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if ls.jumpable(1) then
				ls.jump(1)
			end
		end, { silent = true })

		-- Jump backward
		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		-- Choice node: next
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		-- Choice node: previous
		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			if ls.choice_active() then
				ls.change_choice(-1)
			end
		end, { silent = true })

		------------------------------------------------------------------
		-- Snippet loader (Lua snippets)
		------------------------------------------------------------------
		local snippets_path = vim.fn.stdpath("config") .. "/lua/ani/snippets"
		require("luasnip.loaders.from_lua").lazy_load({
			paths = snippets_path,
		})
	end,
}
