return {
	{
		"neanias/everforest-nvim",
		version = false, -- Use the latest commit
		lazy = false, -- Load the plugin during startup
		priority = 1000, -- Ensure it loads before other plugins
		config = function()
			require("everforest").setup({
				-- Place your configuration options here
				background = "hard", -- Options: "soft", "medium", "hard"
				transparent_background_level = 2,
				italics = true,
				-- Add other customization options as needed
				ui_contrast = "high",
				diagnostic_virtual_text = "coloured",
				diagnostic_line_highlight = true,
				float_style = "dim",
				on_highlights = function(hl, palette)
					hl.Pmenu = { bg = "NONE" }
					hl.PmenuSel = { bg = palette.bg_visual, fg = palette.fg }
					hl.PmenuSbar = { bg = "NONE" }
					hl.PmenuThumb = { bg = palette.grey1 }

					-- if your completion plugin uses floating borders
					hl.FloatBorder = { bg = "NONE" }
					hl.NormalFloat = { bg = "NONE" }
				end,
			})
		end,
	},
}
