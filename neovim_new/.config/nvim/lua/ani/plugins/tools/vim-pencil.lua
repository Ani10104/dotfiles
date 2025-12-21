return {
	"preservim/vim-pencil",
	event = "BufReadPost",
	init = function()
		vim.g["pencil#wrapModeDefault"] = "soft"
	end,
}
