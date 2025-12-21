return {
	"lervag/vimtex",
	event = "BufReadPost",

	init = function()
		------------------------------------------------------------
		-- Filetype
		------------------------------------------------------------
		vim.g.tex_flavor = "latex"

		------------------------------------------------------------
		-- COMPLETION (CRITICAL for blink.cmp)
		------------------------------------------------------------
		vim.g.vimtex_complete_enabled = 1
		vim.g.vimtex_complete_close_braces = 1
		vim.g.vimtex_complete_ignore_case = 1
		vim.g.vimtex_complete_smart_case = 1

		------------------------------------------------------------
		-- Viewer
		------------------------------------------------------------
		vim.g.vimtex_view_method = "sioyek"
		vim.g.vimtex_context_pdf_viewer = "okular"

		------------------------------------------------------------
		-- Compiler
		------------------------------------------------------------
		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			build_dir = "build",
			options = {
				"-pdf",
				"-interaction=nonstopmode",
				"-file-line-error",
				"-synctex=1",
			},
		}

		------------------------------------------------------------
		-- Indentation (disabled, as you prefer)
		------------------------------------------------------------
		vim.g.vimtex_indent_enabled = false
		vim.g.tex_indent_items = false
		vim.g.tex_indent_brace = false

		------------------------------------------------------------
		-- Quickfix / logs (noise reduction)
		------------------------------------------------------------
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_quickfix_ignore_filters = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
			"Package hyperref Warning",
		}

		vim.g.vimtex_log_ignore = {
			"Underfull",
			"Overfull",
			"specifier changed to",
			"Token not allowed in a PDF string",
		}

		------------------------------------------------------------
		-- Mappings
		------------------------------------------------------------
		vim.g.vimtex_mappings_enabled = true
		vim.g.vimtex_mappings_disable = {
			n = {
				"<localleader>ll",
				"<localleader>lv",
			},
		}
	end,
}
