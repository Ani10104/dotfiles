-- lua/ani/config/colorscheme_snacks.lua
local M = {}

function M.pick()
	-- Open Snacks built-in picker
	require("snacks").picker.colorschemes()

	-- When the picker closes, persist the result
	vim.api.nvim_create_autocmd("WinClosed", {
		once = true,
		callback = function()
			local cs = vim.g.colors_name
			if cs and cs ~= AniVim.colorscheme then
				-- update AniVim state
				AniVim.colorscheme = cs

				-- write back to AniVim.lua
				local theme = require("ani.config.theme")
				theme.apply(cs) -- make sure this writes to AniVim.lua
			end
		end,
	})
end

return M
