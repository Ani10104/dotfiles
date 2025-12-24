return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 200
	end,
	opts = {
		setup = {
			show_help = true,
			preset = "helix",
			plugins = {
				presets = {
					operators = false,
					motions = false,
					text_objects = false,
					windows = false,
					nav = false,
					z = false,
					g = false,
					marks = false,
					registers = false,
					spelling = {
						enabled = false,
						suggestions = 10,
					},
				},
			},
			-- Deprecated key_labels replaced with `replace`
			replace = {
				-- e.g. ['<space>'] = 'SPC',
			},
			triggers = {
				{ "<leader>", mode = { "n", "v" } },
			},
			icons = {
				breadcrumb = "»",
				separator = " - ",
				group = "+",
				mappings = true,
			},
			delay = 200, -- use delay instead of triggers_nowait
			-- Deprecated ignore_missing replaced with a filter function
			filter = function(mapping)
				return mapping.desc ~= nil
			end,
			-- Removed deprecated triggers_blacklist
			disable = {
				buftypes = {},
				filetypes = {},
			},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts.setup)

		-- ==========================================================
		-- Inline adapter: spec.lua → which-key
		-- ==========================================================
		-- lua/ani/keymaps/whichkey.lua
		-- ==========================================================

		local spec = require("ani.config.keymaps.spec")

		local items = {}

		for _, section in ipairs(spec) do
			if section.group then
				table.insert(items, {
					section.prefix or "",
					group = section.group,
					icon = section.icon,
				})
			end

			for _, m in ipairs(section.maps or {}) do
				table.insert(items, {
					(section.prefix or "") .. m.key,
					desc = m.desc,
					icon = m.icon,
				})
			end
		end

		wk.add(items)
	end,
}
