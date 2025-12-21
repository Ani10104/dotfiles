return {
	"saghen/blink.cmp",
	version = "1.*",
	event = "InsertEnter",

	dependencies = {
		-- "rafamadriz/friendly-snippets",
		"L3MON4D3/LuaSnip",
		-- {
		-- 	"saghen/blink.compat",
		-- 	version = "*",
		-- 	lazy = true,
		-- 	opts = { impersonate_nvim_cmp = true },
		-- },
	},

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	config = function()
		local cmp = require("blink.cmp")
		local luasnip = require("luasnip")
		local border = AniVim.ui.float.border

		------------------------------------------------------------------
		-- Setup
		------------------------------------------------------------------
		cmp.setup({
			----------------------------------------------------------------
			-- Snippets (LuaSnip)
			----------------------------------------------------------------
			snippets = {
				preset = "luasnip",
				expand = function(snippet)
					luasnip.lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return luasnip.jumpable(filter.direction)
					end
					return luasnip.in_snippet()
				end,
				jump = function(direction)
					luasnip.jump(direction)
				end,
			},

			----------------------------------------------------------------
			-- Completion
			----------------------------------------------------------------
			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},

				menu = {
					border = border,
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
						treesitter = {},
					},
				},

				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					treesitter_highlighting = true,
					window = { border = border },
				},

				ghost_text = {
					enabled = false,
				},
			},

			----------------------------------------------------------------
			-- Signature help
			----------------------------------------------------------------
			signature = {
				enabled = true,
				window = { border = border },
			},

			----------------------------------------------------------------
			-- Sources
			----------------------------------------------------------------
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			----------------------------------------------------------------
			-- Cmdline
			----------------------------------------------------------------
			cmdline = {
				enabled = true,
				completion = { ghost_text = { enabled = false } },
			},

			----------------------------------------------------------------
			-- Appearance
			----------------------------------------------------------------
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
				kind_icons = {
					article = "󰧮 ",
					book = " ",
					incollection = "󱓷 ",
					Function = "󰊕",
					Constructor = " ",
					Text = "󰦨 ",
					Method = " ",
					Field = "󰅪 ",
					Variable = "󱃮 ",
					Class = " ",
					Interface = " ",
					Module = " ",
					Property = "  ",
					Unit = " ",
					Value = "󰚯 ",
					Enum = " ",
					Keyword = " ",
					Snippet = " ",
					Color = "󰌁 ",
					File = " ",
					Reference = " ",
					Folder = " ",
					EnumMember = " ",
					Constant = "󰀫",
					Struct = "",
					Event = "",
					Operator = "󰘧",
					TypeParameter = "",
				},
			},

			----------------------------------------------------------------
			-- Keymaps
			----------------------------------------------------------------
			keymap = {
				preset = "enter",
			},

			----------------------------------------------------------------
			-- Fuzzy matching
			----------------------------------------------------------------
			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
		})
	end,

	opts_extend = { "sources.default" },
}
