-- ============================================================================
-- Canonical keymap specification
--
-- This file is PURE DATA + DOCUMENTATION.
--
-- What this file does:
--   • Declares all keymaps in one place
--   • Optionally attaches icons for UI layers (which-key)
--
-- What this file does NOT do:
--   • It does not call vim.keymap.set
--   • It does not depend on which-key
--   • It does not execute logic directly
--
-- ============================================================================

return {

	-- ─────────────────────────────────────────────────────────────
	-- SEARCH / ESCAPE
	--
	-- Global quality-of-life mappings related to search state
	-- and terminal escape behaviour.
	--
	-- These mappings intentionally have NO prefix to keep them
	-- muscle-memory friendly.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "Search / Escape",

		maps = {
			{
				-- Clear :hlsearch highlights without affecting cursor
				key = "<Esc>",
				mode = "n",
				desc = "Clear search highlight",
				action = "<cmd>nohlsearch<CR>",
			},
			{
				-- Exit terminal-mode cleanly using a double escape
				-- (works better than <Esc> alone in many terminals)
				key = "<Esc><Esc>",
				mode = "t",
				desc = "Exit terminal mode",
				action = "<C-\\><C-n>",
			},
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- WINDOW NAVIGATION
	--
	-- Consistent directional navigation between splits.
	-- These mirror common Vim/Tmux conventions.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "Windows",
		maps = {
			{ key = "<C-h>", mode = "n", desc = "Move focus to left window", action = "<C-w><C-h>" },
			{ key = "<C-l>", mode = "n", desc = "Move focus to right window", action = "<C-w><C-l>" },
			{ key = "<C-j>", mode = "n", desc = "Move focus to lower window", action = "<C-w><C-j>" },
			{ key = "<C-k>", mode = "n", desc = "Move focus to upper window", action = "<C-w><C-k>" },

			{ -- Disable accidental backgrounding via Ctrl-Z
				key = "<C-z>",
				mode = "n",
				desc = "Disable <C-z>",
				action = "<cmd>echo 'Use vim keybind to exit'<CR>",
			},
			-- Split management
			{
				key = "<leader>c",
				mode = "n",
				desc = "Create split",
				icon = { icon = "󰤼", color = "green" },
				action = "<cmd>vert sb<CR>",
			},
			{
				key = "<leader>j",
				mode = "n",
				desc = "Close split",
				icon = { icon = "", color = "red" },
				action = "<cmd>clo<CR>",
			},
			{
				key = "<leader>k",
				mode = "n",
				desc = "Maximize split",
				icon = { icon = "", color = "cyan" },
				action = "<cmd>on<CR>",
			},
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- FOLDS
	--
	-- Fold manipulation helpers.
	-- Includes a smart toggle that opens or closes all folds
	-- depending on current fold state.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "Folds",

		maps = {
			{
				key = "<F9>",
				mode = "n",
				desc = "Toggle all folds",
				action = function()
					local level = vim.opt.foldlevel:get()
					if level == 0 then
						vim.cmd("normal! zR")
					else
						vim.cmd("normal! zM")
					end
				end,
			},

			{ -- Handy insert-mode escape to jump outside brackets
				key = "<C-z>",
				mode = "i",
				desc = "Go outside bracket",
				action = function()
					vim.api.nvim_feedkeys(vim.keycode("<c-o>a"), "n", false)
				end,
			},
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- VIMTEX (STRUCTURAL)
	--
	-- Leader-based LaTeX structural operations.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "[V]imTeX",
		prefix = "<leader>v",
		icon = { icon = "", color = "green" },
		maps = {
			{
				key = "d",
				mode = "n",
				desc = "Delete LaTeX environment",
				icon = { icon = "", color = "red" },
				action = "<Plug>(vimtex-env-delete)",
			},
			{
				key = "c",
				mode = "n",
				desc = "Change LaTeX environment",
				icon = { icon = "", color = "orange" },
				action = "<Plug>(vimtex-env-change)",
			},
		},
	},
	-- ─────────────────────────────────────────────────────────────
	-- VIMTEX (GENERAL)
	--
	-- Common LaTeX editing, compilation, and text objects.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "VimTeX (General)",

		maps = {
			{ key = "<F1>", mode = { "i", "n" }, desc = "Save (insert)", action = "<Esc><cmd>wa!<CR>" },
			{ key = "<F2>", mode = "n", desc = "VimTeX Compile", action = "<cmd>VimtexCompile<CR>" },
			{ key = "<F3>", mode = "n", desc = "VimTeX View", action = "<cmd>VimtexView<CR>" },

			{ key = "ai", mode = { "o", "v" }, desc = "Around items", action = "<Plug>(vimtex-am)" },
			{ key = "ii", mode = { "o", "v" }, desc = "Inside items", action = "<Plug>(vimtex-im)" },
			{ key = "am", mode = { "o", "v" }, desc = "Around math", action = "<Plug>(vimtex-a$)" },
			{ key = "im", mode = { "o", "v" }, desc = "Inside math", action = "<Plug>(vimtex-i$)" },
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- FILES / FIND
	--
	-- Central discovery hub powered by Snacks pickers.
	-- Designed to replace multiple Telescope-like commands.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "[F]ind",
		prefix = "<leader>f",
		icon = { icon = "󰱼", color = "blue" },

		maps = {
			{ -- NOTE: Smart file finder (context-aware)
				key = "f",
				mode = "n",
				desc = "[F]ind [F]iles",
				icon = { icon = "󰈞", color = "cyan" },
				action = function()
					Snacks.picker.smart()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},

			{ -- NOTE: This is a Snippet that does this: [Find Notification]
				key = "N",
				mode = "n",
				desc = "[F]ind [N]otification",
				icon = { icon = "", color = "orange" },
				action = function()
					Snacks.picker.notifications()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Project-wide grep
				key = "g",
				mode = "n",
				desc = "[F]ind [G]rep",
				icon = { icon = "󰱽", color = "yellow" },
				action = function()
					Snacks.picker.grep()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Browse Neovim config
				key = "c",
				mode = "n",
				desc = "[F]ind [C]onfig",
				icon = { icon = "", color = "blue" },
				action = function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config"), title = "Neovim Config", layout = "select" })
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Colorscheme selector
				key = "t",
				mode = "n",
				desc = "[F]ind [T]heme",
				icon = { icon = "", color = "purple" },
				action = function()
					Snacks.picker.colorschemes({
						title = "Themes",
						layout = { preset = "sidebar2", preview = true, layout = { width = 25 } },
					})
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Recently opened files
				key = "r",
				mode = "n",
				desc = "[F]ind [R]ecent",
				icon = { icon = "󰋚", color = "orange" },
				action = function()
					Snacks.picker("oldfiles", { cwd = vim.fn.getcwd() })
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Keymap reference
				key = "k",
				mode = "n",
				desc = "[F]ind [K]eymaps",
				icon = { icon = "󰌌", color = "green" },
				action = function()
					Snacks.picker.keymaps()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Help pages
				key = "h",
				mode = "n",
				desc = "[F]ind [H]elp",
				icon = { icon = "󰞋", color = "cyan" },
				action = function()
					Snacks.picker.help()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Diagnostics overview
				key = "d",
				mode = "n",
				desc = "[F]ind [D]iagnostics",
				icon = { icon = "󰒡", color = "red" },
				action = function()
					Snacks.picker.diagnostics()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Buffer switcher
				key = "b",
				mode = "n",
				desc = "[F]ind [B]uffer",
				icon = { icon = "", color = "blue" },
				action = function()
					Snacks.picker.buffers()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{ -- NOTE: Find Projects
				key = "p",
				mode = "n",
				desc = "[F]ind [P]roject",
				icon = { icon = "", color = "purple" },
				action = function()
					Snacks.picker.projects()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
		},
	},
	-- ─────────────────────────────────────────────────────────────
	-- FILESYSTEM
	--
	-- Lightweight file explorer (Oil)
	-- ─────────────────────────────────────────────────────────────
	{
		group = "Filesystem",

		maps = {
			{ key = "-", mode = "n", desc = "[F]ind [O]il", action = "<cmd>Oil --float<CR>" },
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- RELOAD
	--
	-- Developer productivity helpers.
	-- ─────────────────────────────────────────────────────────────
	{
		group = "[R]eload",
		prefix = "<leader>r",
		icon = { icon = "󰑓", color = "orange" },

		maps = {
			{
				key = "s",
				mode = "n",
				desc = "[R]eload LuaSnip [S]nippets",
				icon = { icon = "", color = "green" },
				action = function()
					local ls = require("luasnip")
					vim.cmd("update")
					ls.cleanup()
					require("luasnip.loaders.from_lua").load({
						paths = vim.fn.stdpath("config") .. "/lua/ani/snippets",
					})
					vim.notify("[LuaSnip] Snippets reloaded!")
				end,
			},
			{
				key = "c",
				mode = "n",
				desc = "[R]eload [C]onfig",
				icon = { icon = "", color = "blue" },
				action = function()
					local session_file = vim.fn.stdpath("state") .. "/Session.vim"
					-- 1. Notify immediately
					vim.notify(" Reloading config…", vim.log.levels.INFO)
					-- 2. Delay the destructive action
					vim.defer_fn(function()
						vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
						vim.cmd("restart source " .. vim.fn.fnameescape(session_file))
					end, 400) -- 0.4 seconds
				end,
			},
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- BUFFER
	-- ─────────────────────────────────────────────────────────────

	{
		group = "[B]uffer",
		prefix = "<leader>b",
		icon = { icon = "", color = "blue" },

		maps = {
			{
				key = "d",
				mode = "n",
				desc = "[B]uffer [D]elete",
				icon = { icon = "󰆴", color = "red" },
				action = function()
					local ok, snacks = pcall(require, "snacks")
					if ok and snacks and snacks.bufdelete then
						Snacks.bufdelete.delete({ silent = true })
					else
						vim.cmd("bdelete")
					end
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
			{
				key = "f",
				mode = "n",
				desc = "[B]uffer [F]ormat",
				icon = { icon = "󰉢", color = "yellow" },
				action = function()
					vim.cmd("keepjumps normal! mz")
					vim.cmd("keepjumps normal! gg=G")
					vim.cmd("keepjumps normal! `z")
					vim.notify("Buffer Formatted")
				end,
			},
			{
				key = "r",
				mode = "n",
				desc = "[B]uffer [R]ename",
				icon = { icon = "󰑕", color = "cyan" },
				action = function()
					Snacks.rename.rename_file()
				end,
				load = "plugin",
				plugin = "folke/snacks.nvim",
			},
		},
	},

	{
		group = "Buffers (Nav)",

		maps = {
			{ key = "<M-h>", mode = "n", desc = "Previous buffer", action = ":bprevious<CR>" },
			{ key = "<M-l>", mode = "n", desc = "Next buffer", action = ":bnext<CR>" },
		},
	},
	-- ─────────────────────────────────────────────────────────────
	-- ZEN / QUIT
	-- ─────────────────────────────────────────────────────────────
	{
		group = "Zen",

		maps = {
			{
				key = "<leader>z",
				mode = "n",
				desc = "[Z]en",
				icon = { icon = "", color = "orange" },
				action = "<cmd>ZenMode|SoftPencil<CR>",
				load = "plugin",
				plugin = "folke/zen-mode.nvim",
			},
		},
	},

	{
		group = "Quit",

		maps = {
			{
				key = "<leader>q",
				mode = "n",
				desc = "[Q]uit to Dashboard",
				icon = { icon = "󰈆", color = "red" },
				action = "<cmd>restart<CR>",
			},
		},
	},

	-- ─────────────────────────────────────────────────────────────
	-- TYPST / GIT
	-- ─────────────────────────────────────────────────────────────
	{
		group = "[T]ypst",
		prefix = "<leader>t",
		icon = { icon = "", color = "blue" },

		maps = {
			{
				key = "p",
				mode = "n",
				desc = "[T]ypst [P]review",
				icon = { icon = "󰈈", color = "green" },
				action = "<cmd>TypstPreview<CR>",
			},
			{
				key = "u",
				mode = "n",
				desc = "[T]ypst Preview [U]pdate",
				icon = { icon = "󰑓", color = "yellow" },
				action = "<cmd>TypstPreviewUpdate<CR>",
			},
		},
	},

	{
		group = "[G]it",
		prefix = "<leader>g",
		icon = { icon = "󰊢", color = "red" },

		maps = {
			{
				key = "l",
				mode = "n",
				desc = "[G]it [L]azygit",
				icon = { icon = "󰊢", color = "red" },
				action = function()
					Snacks.lazygit()
				end,
			},
			load = "plugin",
			plugin = "folke/snacks.nvim",
		},
	},

	{
		group = "[L]ive",
		prefix = "<leader>l",
		icon = { icon = "", color = "red" },

		maps = {
			{
				key = "s",
				mode = "n",
				desc = "[S]tart [L]ive Server",
				icon = { icon = "", color = "yellow" },
				action = ":LiveServerStart<CR>",
				load = "plugin",
				plugin = "barrett-ruth/live-server.nvim",
			},
			{
				key = "k",
				mode = "n",
				desc = "[K]ill [L]ive Server",
				icon = { icon = "", color = "red" },
				action = ":LiveServerStop<CR>",
				load = "plugin",
				plugin = "barrett-ruth/live-server.nvim",
			},
		},
	},
}
