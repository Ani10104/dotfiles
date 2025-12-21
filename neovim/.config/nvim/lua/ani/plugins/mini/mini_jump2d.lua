return {
	"nvim-mini/mini.jump2d",
	event = "BufReadPre", -- safe lazy-load trigger
	config = function()
		require("mini.jump2d").setup() -- No need to copy this inside `setup()`. Will be used automatically.
	end
}
