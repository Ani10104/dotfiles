return {
	"folke/tokyonight.nvim",
	priority = 1000,
	init = function()
		-- Set transparency before applying the colorscheme
		vim.g.tokyonight_disable_background = true
		-- Apply the colorscheme
		-- vim.cmd.colorscheme("tokyonight-night")

		-- Optional: adjust highlights (e.g., remove italics from comments)
		vim.cmd.hi("Comment gui=none")

		-- Ensure active tab shows icon + text
		vim.api.nvim_set_hl(0, "MiniTablineCurrent", {
			link = "TabLineSel",
		})

		-- Optional: inactive tabs
		vim.api.nvim_set_hl(0, "MiniTablineHidden", {
			link = "TabLine",
		})

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
