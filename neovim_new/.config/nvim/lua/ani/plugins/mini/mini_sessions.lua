return {
	"nvim-mini/mini.sessions",
	event = "BufReadPost",
	version = "*",
	config = function()
		-- require("mini.ai").setup()
		require("mini.sessions").setup()
	end,
}
