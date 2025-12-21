return {
	"nvim-mini/mini.operators",
	event = "BufReadPost",
	version = "*",
	config = function()
		-- require("mini.ai").setup()
		require("mini.operators").setup()
	end,
}
