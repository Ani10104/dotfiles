local icons = require('lib.icons')
local M = {}


M.preset = {
	pick = nil,
	keys = {
		{ icon = icons.ui.Search, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
		{ icon =icons.documents.Explorer, key = "e", desc = "Explorer", action = "<cmd>lua MiniFiles.open()<CR>" },
		{ icon =icons.documents.NewFile, key = "n", desc = "New File", action = ":ene | startinsert" },
		{ icon =icons.ui.Search_Text, key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
		{ icon = icons.documents.Recent_Files, key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
		{ icon = icons.ui.Config, key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
		{ icon =icons.ui.Restore, key = "s", desc = "Restore Session", action = "<cmd>SessionManager load_session<CR>" },
		{ icon = icons.ui.Sleep, key = "l", desc = "Lazy", action = ":Lazy" },
		{ icon =icons.type.Boolean, key = "q", desc = "Quit", action = ":qa" },
	},
	header = [[
                                                                         
                                                                       
         ████ ██████           █████      ██                     
        ███████████             █████                             
        █████████ ███████████████████ ███   ███████████   
       █████████  ███    █████████████ █████ ██████████████   
      █████████ ██████████ █████████ █████ █████ ████ █████   
    ███████████ ███    ███ █████████ █████ █████ ████ █████  
   ██████  █████████████████████ ████ █████ █████ ████ ██████ 
                                                                         ]],
}

M.sections = {
	{ section = 'header' },
	{ section = "keys", gap = 0, padding = 1 },
	{ section = 'startup' },
}

return M
