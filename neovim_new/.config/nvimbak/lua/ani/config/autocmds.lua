-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_user_command("LatexNewProject", function(opts)
	require("ani.latex_project").create_latex_project(opts.args)
end, {
	nargs = 1,
	complete = "file",
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "texStyleBold", { fg = "#badfd7", bold = true })
		vim.api.nvim_set_hl(0, "texStyleItal", { fg = "#f7e3db", bold = false })
	end,
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	command = "checktime",
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

local pdf_copy = require("ani.pdf-copy")

vim.api.nvim_create_user_command("LatexExport", pdf_copy.latex_export_pdf, {})

vim.api.nvim_create_user_command("CS", function(opts)
	require("ani.config.theme").apply(opts.args, true)
end, { nargs = 1 })

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		if not vim.g._anivim_cs_persist then
			return
		end

		local cs = vim.g.colors_name
		if not cs then
			return
		end

		-- Persist using your theme system
		require("ani.config.theme").apply(cs)

		-- Reset flag so normal colorscheme changes don't persist
		vim.g._anivim_cs_persist = false
	end,
})
