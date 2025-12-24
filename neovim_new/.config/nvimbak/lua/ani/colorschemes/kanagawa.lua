return {
	"rebelot/kanagawa.nvim",
	priority = 1000,
	config = function()
		require("kanagawa").setup({
			compile = false, -- Faster startup, set to true if you want compilation
			transparent = true, -- Global transparency setting
			dimInactive = false, -- Disable dimming of inactive windows
			colors = { -- Optional: adjust base colors if needed
				theme = {
					all = {
						ui = {
							bg_gutter = "none", -- Make gutter transparent too
						},
					},
				},
			},
			overrides = function(colors)
				local theme = colors.theme
				return {
					-- Floating windows
					NormalFloat = { bg = "none" },
					FloatBorder = { bg = "none", fg = theme.ui.fg_float },
					FloatTitle = { bg = "none", fg = theme.ui.special },

					-- Popup menu
					Pmenu = { bg = "none", fg = theme.ui.shade0 },
					PmenuSel = { bg = theme.ui.bg_p2, fg = theme.ui.fg },
					PmenuSbar = { bg = "none" },
					PmenuThumb = { bg = theme.ui.bg_p2 },

					-- Common plugin floats
					TelescopeTitle = { bg = "none", fg = theme.ui.special },
					TelescopePromptNormal = { bg = "none" },
					TelescopeResultsNormal = { bg = "none" },
					TelescopePreviewNormal = { bg = "none" },
					TelescopeBorder = { bg = "none", fg = theme.ui.fg_float },
					-- mini.files
					MiniFilesBorder = { bg = "none", fg = theme.ui.fg_float }, -- Border color
					MiniFilesTitle = { bg = "none", fg = theme.ui.special }, -- Title color
					MiniFilesNormal = { bg = "none" }, -- File explorer bg
					-- Diagnostic floats
					DiagnosticFloatingError = { bg = "none" },
					DiagnosticFloatingWarn = { bg = "none" },
					DiagnosticFloatingInfo = { bg = "none" },
					DiagnosticFloatingHint = { bg = "none" },

					-- Lazy/Mason floats
					LazyNormal = { bg = "none", fg = theme.ui.fg_dim },
					MasonNormal = { bg = "none", fg = theme.ui.fg_dim },

					-- WhichKey
					WhichKeyFloat = { bg = "none" },
				}
			end,
		})
		-- vim.cmd.colorscheme 'kanagawa'

		-- Additional transparency settings for statusline (if using a transparent statusline plugin)
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
	end,
	build = function()
		vim.cmd("KanagawaCompile") -- Compile for better performance
	end,
}
