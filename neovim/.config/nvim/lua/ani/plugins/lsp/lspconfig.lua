return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },

	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp", -- harmless but unused with blink
	},

	config = function()
		-- remove snippet support
		local base = vim.lsp.protocol.make_client_capabilities()
		base.textDocument.completion.completionItem.snippetSupport = false

		local capabilities = require("blink.cmp").get_lsp_capabilities(base)

		-- diagnostics
		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			virtual_text = false,
		})

		-- TEXLAB
		vim.lsp.config("texlab", {
			capabilities = capabilities,
			settings = {
				texlab = {
					build = { onSave = true },
					chktex = { onEdit = false, onOpenAndSave = false },
					diagnosticsDelay = 300,
				},
			},
		})
		vim.lsp.enable("texlab")

		-- LUA
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")
	end,
}
