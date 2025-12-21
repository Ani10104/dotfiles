-- lua/ani/plugins/editor/mini-pairs.lua
return {
	"echasnovski/mini.pairs",
	version = false,
	event = "InsertEnter",
	config = function()
		require("mini.pairs").setup({
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
				["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
				["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

				['"'] = { action = "open", pair = '""', neigh_pattern = "[^\\]." },
				["'"] = { action = "open", pair = "''", neigh_pattern = "[^%a\\]." },
				["`"] = { action = "open", pair = "``", neigh_pattern = "[^\\]." },

				[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
				["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
				["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
			},
		})
	end,
}
