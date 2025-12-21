-- ~/.config/nvim/lua/ani/config/colorscheme_picker.lua
local Snacks = require("snacks")
local theme = require("ani.config.theme")

local M = {}

function M.pick()
	-- Canonical original (persisted intent)
	local original = vim.g.colors_name

	-- Build items: explicit restore + themes
	local items = {
		{ label = "󰌍 Original (restore)", value = "__ORIGINAL__" },
	}

	for _, name in ipairs(AniVim.colorscheme_options) do
		table.insert(items, { label = name, value = name })
	end

	Snacks.picker.colorschemes({
		title = "Colorschemes",
		layout = { preset = "sidebar2", preview = false, layout = { width = 25 } },
		items = items,

		-- -- 🔍 Preview on movement (NO state mutation)
		-- on_change = function(_, item)
		-- 	if not item or not item.value then
		-- 		return
		-- 	end
		--
		-- 	if item.value == "__ORIGINAL__" then
		-- 		pcall(vim.cmd.colorscheme, original)
		-- 	else
		-- 		pcall(vim.cmd.colorscheme, item.value)
		-- 	end
		-- end,
		--
		-- -- ✅ Confirm selection
		-- confirm = function(picker, item)
		-- 	picker:close()
		-- 	if not item or not item.value then
		-- 		return
		-- 	end
		--
		-- 	if item.value == "__ORIGINAL__" then
		-- 		-- Revert only; do NOT persist
		-- 		pcall(vim.cmd.colorscheme, original)
		-- 	else
		-- 		-- Apply + persist to AniVim.lua
		-- 		theme.apply(item.value, true)
		-- 	end
		-- end,
	})
end

return M
