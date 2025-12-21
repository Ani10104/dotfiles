return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		-- completion sources
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"petertriho/cmp-git",
		"f3fora/cmp-spell",
		"micangl/cmp-vimtex",

		-- snippets
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		------------------------------------------------------------------
		-- Icons
		------------------------------------------------------------------
		local kind_icons = {
			article = "󰧮",
			book = "",
			incollection = "󱓷",
			Function = "󰊕",
			Constructor = "",
			Text = "󰦨",
			Method = "",
			Field = "󰅪",
			Variable = "󱃮",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "󰚯",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "󰌁",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "󰀫",
			Struct = "",
			Event = "",
			Operator = "󰘧",
			TypeParameter = "",
		}

		------------------------------------------------------------------
		-- Mappings
		------------------------------------------------------------------
		local mappings = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<CR>"] = cmp.mapping.confirm({ select = false }),

			-- SuperTab
			["<Tab>"] = cmp.mapping(function(fallback)
				if luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.locally_jumpable(1) then
					luasnip.jump(1)
				elseif cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.locally_jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		})

		------------------------------------------------------------------
		-- Main setup
		------------------------------------------------------------------
		cmp.setup({
			completion = {
				completeopt = "menu,noselect",
				keyword_length = 1,
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = mappings,

			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = function(entry, item)
					item.kind = kind_icons[item.kind] or item.kind
					item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						spell = "[Spell]",
						vimtex = item.menu,
						path = "[Path]",
						cmdline = "[CMD]",
					})[entry.source.name]
					return item
				end,
			},

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "vimtex" },

				{ name = "buffer", keyword_length = 3 },

				{
					name = "spell",
					keyword_length = 4,
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
					},
				},

				{ name = "path" },
			}),

			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},

			view = {
				entries = "custom",
			},

			------------------------------------------------------------------
			-- 👇 COMPLETION WINDOW LIMITS (what you asked for)
			------------------------------------------------------------------
			window = {
				completion = {
					border = "rounded",
					max_height = 7, -- limits long completion lists
					max_width = 50,
				},
				documentation = {
					border = "rounded",
				},
			},

			performance = {
				trigger_debounce_time = 500,
				throttle = 550,
				fetching_timeout = 80,
			},
		})

		------------------------------------------------------------------
		-- Cmdline completion
		------------------------------------------------------------------
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "path" },
				{ name = "cmdline" },
			},
		})
	end,
}
