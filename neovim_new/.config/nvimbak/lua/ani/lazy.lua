-- Lazy bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Collect plugin imports
local imports = {}
for _, plugin_group in ipairs(AniVim.plugin_list) do
	table.insert(imports, { import = plugin_group })
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = imports,

	install = { colorscheme = { AniVim.colorscheme } },

	defaults = {
		-- lazy = true, -- 🚀 lazy-load everything by default!
		version = false,
	},

	performance = {
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"gzip",
				"zip",
				"zipPlugin",
				"tar",
				"tarPlugin",
				"getscript",
				"getscriptPlugin",
				"vimball",
				"vimballPlugin",
				"2html_plugin",
				"logipat",
				"rrhelper",
				"spellfile_plugin",
				"matchit",
				"matchparen",
				"netrw",
				"netrwPlugin",
				"netrwSettings",
				"netrwFileHandlers",
			},
		},
	},
}, {
	ui = {
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
