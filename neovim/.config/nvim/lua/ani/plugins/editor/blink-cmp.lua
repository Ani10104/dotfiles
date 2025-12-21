return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	-- use a release tag to download pre-built binaries
	version = "1.*",
	event = "InsertEnter", -- lazy‑load on first insert
	dependencies = {
		"rafamadriz/friendly-snippets", -- snippet library
		"L3MON4D3/LuaSnip", -- snippet engine
		{
			"saghen/blink.compat", -- nvim‑cmp compatibility layer
			version = "*",
			lazy = true,
			opts = { impersonate_nvim_cmp = true },
		},
		-- { "micangl/cmp-vimtex", lazy = true },  -- VimTeX source for LaTeX
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	config = function()
		local cmp = require("blink.cmp")
		local luasnip = require("luasnip")

		cmp.setup({
			snippets = {
				preset = "luasnip",
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
				active = function(filter)
					if filter and filter.direction then
						return require("luasnip").jumpable(filter.direction)
					end
					return require("luasnip").in_snippet()
				end,
				jump = function(direction)
					require("luasnip").jump(direction)
				end,
			},
			completion = {
				accept = {
					auto_brackets = { enabled = true },
				},
				menu = {
					border = AniVim.ui.float.border,
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
						treesitter = {},
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					treesitter_highlighting = true,
					window = {
						border = AniVim.ui.float.border,
					},
				},

				ghost_text = { enabled = false },
			},
			signature = {
				enabled = true,
				window = {
					border = AniVim.ui.float.border,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			cmdline = { enabled = true },
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
			keymap = {
				preset = "enter",
				-- ["<Tab>"] = { "select_next", "fallback" },
				-- ["<S-Tab>"] = { "select_prev", "fallback" },
				-- Additional key mappings can be added here
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		})
	end,
	opts_extend = { "sources.default" },
}
