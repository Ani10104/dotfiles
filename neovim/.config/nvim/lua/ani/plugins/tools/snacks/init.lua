local icons = require("lib.icons")
return {
	"folke/snacks.nvim",
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
			},
		},
		bigfile = { enabled = AniVim.snacks_enabled(AniVim.snacks_module.bigfile), notify = true },
		lazygit = { enabled = AniVim.snacks_enabled(AniVim.snacks_module.lazygit) },
		dashboard = {
			enabled = AniVim.snacks_enabled(AniVim.snacks_module.dashboard),
			preset = require("ani.plugins.tools.snacks.dashboard").preset,
			sections = require("ani.plugins.tools.snacks.dashboard").sections,
		},
		buffdelete = { enabled = AniVim.snacks_enabled(AniVim.snacks_module.buffdelete) },
		indent = { enabled = AniVim.snacks_enabled(AniVim.snacks_module.indent) },
		input = {
			enabled = AniVim.snacks_enabled(AniVim.snacks_module.input),
			backdrop = false,
			position = "float",
			border = "rounded",
			title_pos = "center",
			icon_hl = "SnacksInputIcon",
			icon_pos = "left",
			prompt_pos = "title",
			win = { style = "input" },
			expand = true,
		},
		picker = {
			enabled = false,
			open = {
				split = "right",
			},
			layout = "custom1",
			layouts = {
				custom1 = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = "none",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{
							box = "horizontal",
							{ win = "list", border = "rounded" },
							{ win = "preview", rtitle = "{preview}", width = 0.4, border = "rounded" },
						},
						{ win = "input", height = 1, border = "rounded" },
					},
				},
				bettercode = {
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						max_width = 100,
						height = 0.4,
						min_height = 2,
						box = "vertical",
						border = true,
						title = "{title}",
						title_pos = "center",
						{ win = "input", height = 1, border = "rounded" },
						{ win = "list", border = "none" },
					},
				},
				select2 = {
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						max_width = 100,
						height = 0.2,
						min_height = 2,
						box = "vertical",
						border = true,
						title = "{title}",
						title_pos = "center",
						{ win = "list", border = "none" },
						{ win = "input", height = 1, border = "top" },
					},
				},
				sidebar2 = {
					layout = {
						backdrop = false,
						width = 40,
						min_width = 40,
						height = 0,
						position = "right",
						border = "none",
						box = "vertical",
						{
							win = "input",
							height = 1,
							border = true,
							title = "{title} {live} {flags}",
							title_pos = "center",
						},
						{ win = "list", border = "rounded" },
						{ win = "preview", title = "{preview}", height = 0.1, border = "top" },
					},
				},
			},
			hidden = true, -- Show hidden files by default
			ignored = true, -- Show ignored files by default
			sources = {
				files = {
					hidden = true,
					follow_file = true,
					layout = "custom1",
					-- Additional configurations as needed
				},
				recent = {
					layout = "custom1",
				},
				help = {
					-- layout = { preset = "bettercode", preview = false },
					layout = "select",
				},
				keymaps = {
					-- layout = { preset = "bettercode", preview = false },
					layout = "select",
				},
				buffers = {
					-- layout = { preset = "bettercode", preview = false },
					layout = "select2",
				},

				colorschemes = {
					finder = "vim_colorschemes",
					format = "text",
					preview = "colorscheme",
					confirm = function(picker, item)
						picker:close()
						if item then
							picker.preview.state.colorscheme = nil
							vim.schedule(function()
								vim.cmd("CS " .. item.text)
							end)
						end
					end,
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
			sort = { "level", "added" },
			level = vim.log.levels.TRACE,
			style = "compact",
			top_down = true,
			date_format = "%R",
			more_format = " ↓ %d lines ",
			refresh = 50,
		},
		notify = { enabled = true },
		rename = { enabled = true },
		profiler = { enabled = false },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" },
			right = { "fold", "git" },
			folds = {
				open = false,
				git_hl = false,
			},
			git = {
				patterns = { "GitSign", "MiniDiffSign" },
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
				diagnostics = false,
				-- inlay_hints = false,
			},
			show = {
				statusline = false,
				tabline = false,
			},
			win = { style = "zen" },
			zoom = {
				toggles = {},
				show = { statusline = true, tabline = false },
				win = {
					backdrop = true,
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

		Snacks.picker.anivim_colorschemes = function()
			require("ani.config.colorscheme_picker").pick()
		end
	end,

	keys = {
		-- Top Pickers & Explorer
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
	},
}
