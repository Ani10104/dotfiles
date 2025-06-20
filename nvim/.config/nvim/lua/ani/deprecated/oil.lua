return {
	'stevearc/oil.nvim',
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	keys = {
		{
			'-',
			'<cmd>Oil --float<CR>',
			desc = "Open Oil in floating window",
		},
	},
	config = function()
		require("oil").setup({
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			view_options = {
				show_hidden = true,
				natural_order = true,
				is_always_hidden = function(name, _)
					return name == '..' or name == '.git'
				end,
			},
			win_options = {
				wrap = true,
			}
		})
	end,
	lazy = false,
}
