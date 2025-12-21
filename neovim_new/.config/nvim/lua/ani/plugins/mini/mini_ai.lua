return {
	"nvim-mini/mini.ai",
	event = "BufReadPost",
	version = "*",
	config = function()
		-- require("mini.ai").setup()
		require("mini.ai").setup( -- No need to copy this inside `setup()`. Will be used automatically.
			{
				-- Whether to show file icons (requires 'mini.icons')
				show_icon = true,

				format = function(buf_id, label)
					local name = vim.fn.fnamemodify(label, ":t")

					-- IMPORTANT: pass the real buf_id here
					local formatted = MiniTabline.default_format(buf_id, name)

					-- trim Mini's padding
					formatted = formatted:gsub("^%s+", ""):gsub("%s+$", "")

					return formatted .. " | "
				end,

				-- Where to show tabpage section in case of multiple vim tabpages.
				-- One of 'left', 'right', 'none'.
				tabpage_section = "left",
			}
		)
	end,
}
