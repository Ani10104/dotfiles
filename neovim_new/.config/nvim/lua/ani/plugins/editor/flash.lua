return {
	-----------------------------------------------------------------------------
	-- ⚡ Flash.nvim
	-- Fast, label-based navigation across buffers, operators, and pickers
	-----------------------------------------------------------------------------
	"folke/flash.nvim",
	lazy = true,
	-- event = { "BufReadPost", "BufNewFile" },

	opts = {},
	-----------------------------------------------------------------------------
	-- 🔑 Global Flash keymaps
	-----------------------------------------------------------------------------
	keys = {
		-- Main Flash jump (you use <CR> instead of `s`)
		{
			"<CR>",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash Jump",
		},

		-- Treesitter-based Flash navigation
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},

		-- Remote Flash (operator-pending)
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},

		-- Treesitter-powered search Flash
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},

		-- Toggle Flash during `/` and `?` search
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},

	-----------------------------------------------------------------------------
	-- 🍿 Snacks.nvim integration
	-- Enables Flash-style jumping *inside* Snacks picker lists
	-- (Scoped only to the picker, does NOT affect global Flash behavior)
	-----------------------------------------------------------------------------
	specs = {
		{
			"folke/snacks.nvim",
			optional = true,

			opts = {
				picker = {
					---------------------------------------------------------------------
					-- ⌨️ Picker input window keymaps
					---------------------------------------------------------------------
					win = {
						input = {
							keys = {
								-- Flash jump within the picker list
								["s"] = { "flash" },

								-- Same action, available in normal + insert mode
								["<a-s>"] = { "flash", mode = { "n", "i" } },
							},
						},
					},

					---------------------------------------------------------------------
					-- 🎯 Picker actions
					---------------------------------------------------------------------
					actions = {
						-- Flash-powered row jump inside Snacks picker
						flash = function(picker)
							require("flash").jump({
								-- Match the beginning of each picker row
								pattern = "^",

								-- Place labels at row start
								label = { after = { 0, 0 } },

								-- Restrict Flash to Snacks picker list window only
								search = {
									mode = "search",
									exclude = {
										function(win)
											return vim.bo[vim.api.nvim_win_get_buf(win)].filetype
												~= "snacks_picker_list"
										end,
									},
								},

								-- Move picker selection to the chosen Flash match
								action = function(match)
									local idx = picker.list:row2idx(match.pos[1])
									picker.list:_move(idx, true, true)
								end,
							})
						end,
					},
				},
			},
		},
	},
}
