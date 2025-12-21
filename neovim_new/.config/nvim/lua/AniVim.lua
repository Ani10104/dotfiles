-------------------------------------------------
--         Main Configuration File             --
-------------------------------------------------
--        ___           __    __               --
--       /   |  ____  (_) |  / (_)___ ___      --
--      / /| | / __ \/ /| | / / / __ `__ \     --
--     / ___ |/ / / / / | |/ / / / / / / /     --
--    /_/  |_/_/ /_/_/  |___/_/_/ /_/ /_/      --
--                                             --
-------------------------------------------------

local icons = require("lib.icons")

AniVim = {
	-- Available themes
	colorscheme = "kanagawa-wave",

	themes = {
		-- "gruvbox",
		-- "tokyonight",
		-- "catppuccin",
		"kanagawa",
		"rose-pine",
		-- "everforest",
		-- "nightfox",
		-- "vague",
	},

	plugin_list = {
		"ani.plugins",
		"ani.plugins.editor",
		"ani.plugins.ui",
		"ani.plugins.lsp",
		"ani.plugins.tools",
		"ani.plugins.latex",

		--Mini Plugins
		"ani.plugins.mini.mini_ai",
		"ani.plugins.mini.mini_tabline",
		"ani.plugins.mini.mini_statusline",
		"ani.plugins.mini.mini_surround",
		"ani.plugins.mini.mini_operators",
		"ani.plugins.mini.mini_pairs",
		-- "ani.plugins.mini.mini_sessions",
	},

	ui = {
		font = { "FiraCode Nerd Font", ":h14" },
		float = { border = "rounded" },
	},
	snacks_module = {
		picker = 1,
		bigfile = 1,
		lazygit = 1,
		buffdelete = 1,
		indent = 1,
		input = 1,
		notifier = 1,
		notify = 1,
		rename = 1,
		profiler = 1,
		quickfile = 1,
		scope = 1,
		scroll = 1,
		statuscolumn = 1,
		words = 1,
		zen = 0,
		dashboard = 1,
	},
	icons = icons,

	statusline = {
		path_enabled = false,
		path = "relative",
	},
}

function AniVim.snacks_enabled(v)
	return v == 1
end

return AniVim
