return {
	"ellisonleao/gruvbox.nvim",
	lazy = true,
	priority = 1000, -- ensures gruvbox loads before other plugins
	config = function()
		require("gruvbox").setup({
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines, and errors
			contrast = "soft", -- options: "hard", "soft", or empty string
			palette_overrides = {},
			overrides = {},
			dim_inactive = false,
			transparent_mode = true,
		})
		vim.o.background = "dark" -- set to "light" for light mode
		-- make floating windows transparent
		vim.api.nvim_set_hl(0, "normalfloat", { bg = "none" })
		vim.api.nvim_set_hl(0, "floatborder", { bg = "none" })
		vim.api.nvim_set_hl(0, "floattitle", { bg = "none" })

		-- optional but recommended
		vim.api.nvim_set_hl(0, "winseparator", { bg = "none" })

		-- completion menu (nvim-cmp / native)
		vim.api.nvim_set_hl(0, "pmenu", { bg = "none" })
		vim.api.nvim_set_hl(0, "pmenusel", { bg = "none" })
		vim.api.nvim_set_hl(0, "pmenusbar", { bg = "none" })
		vim.api.nvim_set_hl(0, "pmenuthumb", { bg = "none" })

		-- ensure active tab shows icon + text
		vim.api.nvim_set_hl(0, "minitablinecurrent", {
			link = "tablinesel",
		})

		-- optional: inactive tabs
		vim.api.nvim_set_hl(0, "minitablinehidden", {
			link = "tabline",
		})
	end,
}
