local icons = require('lib.icons')
return {
	'folke/snacks.nvim',
	priority = 1000,
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true,  notify = true},
		dashboard = {
			enabled = true,
			preset = {
				pick = function(cmd, opts)
					return Snacks.picker.pick(cmd, opts)
				end,

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
				-- stylua: ignore
				---@type snacks.dashboard.Item[]
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
			},
		},
		buffdelete = {enabled = true},
		indent = { enabled = true },
		input = { enabled = true, icon = icons.ui.Edit,
			icon_hl = 'SnacksInputIcon',
			icon_pos = 'left',
			prompt_pos = 'title',
			win = { style = 'input' },
			expand = true, },
		picker = {
			enabled = true,
			hidden = true, -- Show hidden files by default
			ignored = true, -- Show ignored files by default
			sources = {
				files = {
					hidden = true,
					follow_file = true,
					-- Additional configurations as needed
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		zen = {
			enabled = true,
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				-- diagnostics = false,
				-- inlay_hints = false,
			},
			show = {
				statusline = false,
				tabline = false,
			},
			win = { style = 'zen' },
			zoom = {
				toggles = {},
				show = { statusline = true, tabline = true },
				win = {
					backdrop = false,
					width = 0,
				},
			},
		},

		latex = {
			patterns = {
				{
					match = [[\\textbf{([^}]*)}]],
					group = 1,
					style = "bold",
				},
				{
					match = [[\\textit{([^}]*)}]],
					group = 1,
					style = "italic",
				},
				{
					match = [[\\emph{([^}]*)}]],
					group = 1,
					style = "italic",
				},
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			'<leader><space>',
			function()
				Snacks.picker.smart()
			end,
			desc = 'Smart Find Files',
		},
		{
			'<leader>un',
			function()
				Snacks.notifier.hide()
			end,
			desc = 'Dismiss All Notifications',
		},
		-- {
		--   '<c-/>',
		--   function()
		--     Snacks.terminal()
		--   end,
		--   desc = 'Toggle Terminal',
		-- },
	},
}
