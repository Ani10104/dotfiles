-- ~/.config/nvim/lua/ani/core/theme.lua
local M = {}

local function write_to_anivim(name)
	local path = vim.fn.stdpath("config") .. "/lua/ani/config/AniVim.lua"

	local lines = vim.fn.readfile(path)
	for i, line in ipairs(lines) do
		if line:match("colorscheme%s*=") then
			lines[i] = string.format('  colorscheme = "%s",', name)
			break
		end
	end

	vim.fn.writefile(lines, path)
end

-- Runtime preview ONLY
function M.preview(name)
	pcall(vim.cmd.colorscheme, name)
end

function M.apply(name, persist)
	name = name or AniVim.colorscheme

	local ok = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify("Colorscheme not found: " .. name, vim.log.levels.ERROR)
		return
	end

	AniVim.ui.colorscheme = name

	if persist then
		write_to_anivim(name)
	end
end

return M
