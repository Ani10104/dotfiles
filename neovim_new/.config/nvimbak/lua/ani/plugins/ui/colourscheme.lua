local specs = {}

-- 1. Import all colorscheme plugin specs
for _, theme in ipairs(AniVim.themes) do
	local ok, spec = pcall(require, "ani.colorschemes." .. theme)
	if ok then
		table.insert(specs, spec)
	else
		vim.notify("AniVim: Theme not found: ani.colorschemes." .. theme, vim.log.levels.WARN)
	end
end

-- 2. Apply the selected colorscheme safely
local function apply_colorscheme()
	local name = AniVim.colorscheme
	if not name or name == "" then
		vim.notify("AniVim: No colorscheme set", vim.log.levels.WARN)
		return
	end

	local ok = pcall(vim.cmd.colorscheme, name)
	if not ok then
		vim.notify("AniVim: Colorscheme not found: " .. name, vim.log.levels.ERROR)
	end
end

-- Defer application so lazy.nvim has registered plugins
vim.schedule(apply_colorscheme)

return specs
