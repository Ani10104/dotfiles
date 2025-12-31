return {
	"folke/tokyonight.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		transparent = true,
		styles = {
			comments = { italic = false },
			sidebars = "transparent",
			floats = "transparent",
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight-night")

		-- comments without italics
		vim.cmd.hi("Comment gui=none")

		-- floating windows
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
		vim.api.nvim_set_hl(0, "FloatTitle", { bg = "none" })

		-- separators
		vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none" })

		-- completion menu
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "none" })
		vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "none" })
		vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "none" })

		-- MiniTabline (correct casing)
		vim.api.nvim_set_hl(0, "MiniTablineCurrent", { link = "TabLineSel" })
		vim.api.nvim_set_hl(0, "MiniTablineHidden", { link = "TabLine" })
	end,
}
