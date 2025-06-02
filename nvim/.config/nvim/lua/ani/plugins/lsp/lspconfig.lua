return {
	'neovim/nvim-lspconfig',
	event = { 'BufReadPre', 'BufNewFile' },
	dependencies = {
		-- Mason must be loaded before its dependents so we need to set it up here.
		{ 'williamboman/mason.nvim', opts = {} },
		'williamboman/mason-lspconfig.nvim',
		'WhoIsSethDaniel/mason-tool-installer.nvim',

		-- Useful status updates for LSP.
		-- { 'j-hui/fidget.nvim', opts = {} },

		-- Allows extra capabilities provided by nvim-cmp
		'hrsh7th/cmp-nvim-lsp',
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require 'lspconfig'

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require 'cmp_nvim_lsp'

		-- used to enable autocompletion (assign to every lsp server config)
		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require('blink.cmp').get_lsp_capabilities(original_capabilities )
		local default = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = '', Warn = '', Hint = '󰠠', Info = '' }
		for type, icon in pairs(signs) do
			local hl = 'DiagnosticSign' .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
		end
		-- Diagnostic Config
		-- See :help vim.diagnostic.Opts
		vim.diagnostic.config {
			severity_sort = true,
			float = { border = 'rounded', source = 'if_many' },
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = vim.g.have_nerd_font and {
				text = {
					[vim.diagnostic.severity.ERROR] = '󰅚 ',
					[vim.diagnostic.severity.WARN] = '󰀪 ',
					[vim.diagnostic.severity.INFO] = '󰋽 ',
					[vim.diagnostic.severity.HINT] = '󰌶 ',
				},
			} or {},
			virtual_text = {
				source = 'if_many',
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		}

		-- -- configure html server
		-- lspconfig["html"].setup({
		--   capabilities = default,
		-- })

		-- -- configure typescript server with plugin
		-- lspconfig["tsserver"].setup({
		--   capabilities = default,
		-- })

		-- -- configure emmet language server
		-- lspconfig["emmet_ls"].setup({
		--   capabilities = default,
		--   filetypes = { "html", "typescriptreact", "javascriptreact" }, -- , "css", "sass", "scss", "less", "svelte"
		-- })

		-- configure latex server
		lspconfig['texlab'].setup {
			capabilities = capabilities ,
			settings = {
				texlab = {
					build = {
						onSave = true,
					},
					chktex = {
						onEdit = false,
						onOpenAndSave = false,
					},
					diagnosticsDelay = 300,
					-- formatterLineLength = 80,
					-- bibtexFormatter = "texlab",
					-- -- Set up bibliography paths
					-- bibParser = {
					--   enabled = true,
					--   -- Add paths where your .bib files might be located
					--   paths = {
					--     "./bib",           -- bib folder in current directory
					--     "~/texmf/bibtex/bib", -- bib folder in Documents
					--     vim.fn.expand("$HOME/texmf/bibtex/bib"), -- Expanded path to Bibliography folder
					--   },
					-- },
					-- -- Enable forward search and inverse search if needed
					-- forwardSearch = {
					--   enabled = true,
					-- },
				},
			},
			}

			-- configure python server
			-- lspconfig['pyright'].setup {
			-- 	capabilities = default,
			-- }
			-- configure lua server (with special settings)
			lspconfig['lua_ls'].setup {
				capabilities = capabilities,
				settings = {
					-- custom settings for lua
					Lua = {
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand '$VIMRUNTIME/lua'] = true,
								[vim.fn.stdpath 'config' .. '/lua'] = true,
							},
						},
					},
				},
			}
	end,
}
