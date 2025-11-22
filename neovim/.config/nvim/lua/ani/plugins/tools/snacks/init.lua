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
		styles = {
			blame_lines = {
				width = 0.6,
				height = 0.6,
				border = "rounded",
				title = " Git Blame ",
				title_pos = "center",
				ft = "git",
			}
		},
		bigfile = { enabled = true,  notify = true},
		dashboard = {
			enabled = true,
			preset = require("ani.plugins.tools.snacks.dashboard").preset,
			sections = require("ani.plugins.tools.snacks.dashboard").sections,
		},
		buffdelete = {enabled = true},
		indent = { enabled = true },
		input = {
			enabled = true,
			backdrop = false,
			position = "float",
			border = "rounded",
			title_pos = "center",
			icon_hl = 'SnacksInputIcon',
			icon_pos = 'left',
			prompt_pos = 'title',
			win = { style = 'input' },
			expand = true,
		},
		picker = {
			enabled = true,
			layout = {
				-- preview = "main",
				preset = "ivy",
			},
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
		notifier = {
			enabled = true,
			timeout = 4000,
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true,
			sort = { 'level', 'added' },
			level = vim.log.levels.TRACE,
			style = 'compact',
			top_down = true,
			date_format = '%R',
			more_format = ' ↓ %d lines ',
			refresh = 50,
		},
		notify = { enabled = true },
		profiler = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = {
			enabled = true,
			left = { 'mark', 'sign' },
			right = { 'fold', 'git' },
			folds = {
				open = false,
				git_hl = false,
			},
			git = {
				patterns = { 'GitSign', 'MiniDiffSign' },
			},
			refresh = 50,
		},
		words = { enabled = false },
		zen = {
			enabled = false,
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

	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)
		-- Set vim.ui.input to use Snacks.input
		vim.ui.input = snacks.input
	end,

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
	},
}
