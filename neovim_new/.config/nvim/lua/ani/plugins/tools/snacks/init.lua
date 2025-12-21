local icons = require("lib.icons")
local layouts = require("ani.plugins.tools.snacks.layouts")
local keyspec = require("ani.config.keymaps.lazy_keymaps").for_plugin("folke/snacks.nvim")
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
			layouts = layouts,
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

				explorer = {
					layout = { preset = "default", preview = false },
					-- layout = "default",
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
		explorer = {
			enabled = true,
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
	},
	keys = keyspec,
	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)
		-- Set vim.ui.input to use Snacks.input
		vim.ui.input = snacks.input
	end,
}
