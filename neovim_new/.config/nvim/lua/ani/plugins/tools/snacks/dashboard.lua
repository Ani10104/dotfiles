local icons = require("lib.icons")
local M = {}

M.preset = {
	pick = nil,
	keys = {
		{ icon = icons.ui.Search, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
		{
			icon = icons.documents.Explorer,
			key = "e",
			desc = "Explorer",
			action = "<cmd>lua Snacks.picker.explorer()<cr>",
		},
		-- { icon = icons.documents.NewFile, key = "n", desc = "New File", action = ":ene | startinsert" },
		{
			icon = icons.ui.Search_Text,
			key = "g",
			desc = "Find Text",
			action = ":lua Snacks.dashboard.pick('live_grep')",
		},
		{
			icon = icons.documents.Recent_Files,
			key = "r",
			desc = "Recent Files",
			action = ":lua Snacks.dashboard.pick('oldfiles')",
		},
		{
			icon = icons.ui.Config,
			key = "c",
			desc = "Config",
			action = ":Oil --float ~/.config/nvim/",
		},
		-- {
		-- 	icon = icons.ui.Restore,
		-- 	key = "s",
		-- 	desc = "Restore Session",
		-- 	action = "<cmd>lua MiniSessions.read(nil)<CR>",
		-- },
		{ icon = icons.ui.Sleep, key = "l", desc = "Lazy", action = ":Lazy" },
		{ icon = icons.type.Boolean, key = "q", desc = "Quit", action = ":qa" },
	},
	header = [[
   ▄████████ ███▄▄▄▄    ▄█   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   
  ███    ███ ███▀▀▀██▄ ███  ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ 
  ███    ███ ███   ███ ███▌ ███    ███ ███▌ ███   ███   ███ 
  ███    ███ ███   ███ ███▌ ███    ███ ███▌ ███   ███   ███ 
▀███████████ ███   ███ ███▌ ███    ███ ███▌ ███   ███   ███ 
  ███    ███ ███   ███ ███  ███    ███ ███  ███   ███   ███ 
  ███    ███ ███   ███ ███  ███    ███ ███  ███   ███   ███ 
  ███    █▀   ▀█   █▀  █▀    ▀██████▀  █▀    ▀█   ███   █▀  
                                                            
	]],
}

M.sections = {
	{ section = "header" },
	-- {
	-- 	pane = 2,
	-- 	section = "terminal",
	-- 	cmd = "cowsay Welcome Aniruddha. This is a Nice Dashboard innit?",
	-- 	hl = "header",
	-- 	padding = 1,
	-- 	indent = 8,
	-- },
	{ section = "keys", gap = 1, padding = 1 },
	-- { pane = 2, icon = " ", desc = "Recent Files", padding = 1 },
	-- { pane = 2, section = "recent_files", indent = 2, padding = 1 },
	-- { pane = 2, icon = " ", desc = "Projects", padding = 1 },
	-- { pane = 2, section = "projects", indent = 2, padding = 2 },
	{ section = "startup" },
}
return M
