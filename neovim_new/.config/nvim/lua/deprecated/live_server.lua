local keyspec = require("ani.config.keymaps.lazy_keymaps").for_plugin("barrett-ruth/live-server.nvim")
return {
	"barrett-ruth/live-server.nvim",
	ft = { "html", "javascriptreact", "typescriptreact" },
	build = "npm install -g live-server",
	config = function()
		require("live-server").setup({
			args = { "--port=8080" }, -- optional custom args
		})
	end,
	keys = keyspec,
}
