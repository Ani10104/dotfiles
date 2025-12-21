------------------------------------------------------------
---------------------- Keymap Helpers ----------------------
------------------------------------------------------------

local map = vim.keymap.set
local opts = { noremap = true, silent = true }
--description with opts
local function opt(desc)
	return vim.tbl_extend("force", opts, { desc = desc })
end

------------------------------------------------------------
------------------- Search / Escape Maps -------------------
------------------------------------------------------------

vim.opt.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", opt("Exit terminal mode"))

------------------------------------------------------------
------------------- Window Navigation ----------------------
------------------------------------------------------------

--  Use CTRL+<hjkl> to switch between windows
map("n", "<C-h>", "<C-w><C-h>", opt("Move focus to the left window"))
map("n", "<C-l>", "<C-w><C-l>", opt("Move focus to the right window"))
map("n", "<C-j>", "<C-w><C-j>", opt("Move focus to the lower window"))
map("n", "<C-k>", "<C-w><C-k>", opt("Move focus to the upper window"))
map("n", "<C-z>", "<cmd>echo 'Use vim keybind to exit'<CR>", opt("Disabl <c-z>"))
map("n", "<leader>c", "<cmd>vert sb<CR>", opt("create split"))
map("n", "<leader>j", "<cmd>clo<CR>", opt("drop split"))
map("n", "<leader>k", "<cmd>on<CR>", opt("max split"))

------------------------------------------------------------
----------------------- Fold Toggles -----------------------
------------------------------------------------------------
local function toggle_all_folds()
	local current_foldlevel = vim.opt.foldlevel:get()
	if current_foldlevel == 0 then
		vim.cmd("normal! zR") -- Open all folds
	else
		vim.cmd("normal! zM") -- Close all folds
	end
end
-- Map <F9> to toggle all folds
map("n", "<F9>", function()
	toggle_all_folds()
end, opt("Toggle All Folds"))

map("i", "<C-z>", function()
	-- temporarily go to NORMAL mode, move to matching bracket, go right, return to INSERT
	vim.api.nvim_feedkeys(vim.keycode("<c-o>a"), "n", false)
end, opt("go outside bracket"))

-----------------------------------------------------------
--------------------------[Vimtex]-------------------------
-----------------------------------------------------------

--Save using F1
map("n", "<F1>", "<cmd>wa!<CR>", opt("Save"))
map("i", "<F1>", "<Esc><cmd>wa!<CR>", opt("Save in Insert"))
-- Compile and View
map("n", "<F2>", "<cmd>VimtexCompile<CR>", opt("VimCompile"))
map("n", "<F3>", "<cmd>VimtexView<CR>", opt("VimView"))
--Environment
map("n", "<leader>vd", "<Plug>(vimtex-env-delete)", opt("Delete LaTeX Environment"))

-- 'ai' and 'ii' for the item text object
map({ "o", "v" }, "ai", "<Plug>(vimtex-am)", opt("Around Items"))
map({ "o", "v" }, "ii", "<Plug>(vimtex-im)", opt("Inside Items"))

--'am' and 'im' for the inline math text object
map({ "o", "v" }, "am", "<Plug>(vimtex-a$)", opt("Around Math"))
map({ "o", "v" }, "im", "<Plug>(vimtex-i$)", opt("Inside Math"))
-----------------------------------------------------------
--------------------------[Files]--------------------------
-----------------------------------------------------------
-- Find Files
map("n", "<leader>ff", "<cmd>lua Snacks.picker.smart()<CR>", opt("Smart Find Files"))

-- Find Files
map("n", "<leader>fg", "<cmd>lua Snacks.picker.grep()<CR>", opt("Smart Find Files"))

-- Find Config
map(
	"n",
	"<leader>fc",
	"<cmd>lua Snacks.picker.files({ cwd = vim.fn.stdpath('config'), title = 'Neovim Config', layout = 'select',})<CR>",
	opt("[F]ind [C]onfig")
)

map(
	"n",
	"<leader>ft",
	"<cmd>lua Snacks.picker.colorschemes({title = 'Neovim Config', layout = { preset = 'sidebar2', preview = true, layout = { width = 25 } },})<CR>",
	opt("[F]ind [C]onfig")
)
map("n", "-", "<cmd>Oil --float<CR>", opt("[F]ind [O]il"))
-- Find Recent
map("n", "<leader>fr", "<cmd>lua Snacks.picker('oldfiles', { cwd = vim.fn.getcwd() })<CR>", opt("[F]ind [R]ecent"))
-- Find Buffer

-- Find Keymaps
map("n", "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<CR>", opt("[F]ind [k]eymaps"))

-- Find Help
map("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<CR>", opt("[F]ind [H]elp"))

--Find Diagnostic
map("n", "<leader>fd", "<cmd>lua Snacks.picker.diagnostics()<CR>", opt("[F]ind [D]iagnostics"))

--Find Diagnostic
map("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<CR>", opt("[F]ind [B]uffer"))
-----------------------------------------------------------
--------------------------[Reload]-------------------------
-----------------------------------------------------------

-- Reload LuaSnip snippets manually
function _G.ReloadSnippets()
	local ls = require("luasnip")
	vim.cmd("update")
	ls.cleanup() -- clears old snippets to avoid duplication
	require("luasnip.loaders.from_lua").load({
		paths = vim.fn.stdpath("config") .. "/lua/ani/snippets",
	})
	print("[LuaSnip] Snippets reloaded!")
	vim.defer_fn(function()
		vim.cmd("echo ''") -- clears the cmdline
	end, 4000)
end

-- Reload Snippet file
vim.keymap.set("n", "<leader>rs", ReloadSnippets, opt("[R]eload LuaSnip [S]nippets"))

--Reload or Source config
map("n", "<leader>rc", function()
	vim.cmd("source")
	print("[Neovim] Config Reloaded")
	vim.defer_fn(function()
		vim.cmd("echo ''") -- clears the cmdline
	end, 4000)
end, opt("[R]eload [C]onfig"))

-----------------------------------------------------------
--------------------------[Buffer]-------------------------
-----------------------------------------------------------

map("n", "<M-h>", ":bprevious<CR>", opt("Previous buffer"))
map("n", "<M-l>", ":bnext<CR>", opt("Next buffer"))

--Delete Buffer
map("n", "<leader>bd", function()
	local ok, snacks = pcall(require, "snacks")
	if ok and snacks and snacks.bufdelete then
		Snacks.bufdelete.delete(opts)
	else
		vim.cmd("bdelete") -- Fallback: native Vim buffer delete
	end
end, opt("[B]uffer [D]elete"))

--Format Buffer
map("n", "<leader>bf", function()
	-- save cursor position WITHOUT adding to jumplist
	vim.cmd("keepjumps normal! mz")

	-- reindent entire file WITHOUT adding to jumplist
	vim.cmd("keepjumps normal! gg=G")

	-- restore cursor WITHOUT adding to jumplist
	vim.cmd("keepjumps normal! `z")

	-- message
	vim.notify("Buffer Formatted")
end, opt("[B]uffer [F]ormat"))

--Rename Buffer
map("n", "<leader>br", "<cmd>lua Snacks.rename.rename_file() <CR>", opt("[B]ufer [R]ename"))

-----------------------------------------------------------
--------------------------[ZenMode]------------------------
-----------------------------------------------------------
map("n", "<leader>z", "<cmd>ZenMode|SoftPencil<CR>", opt("[Z]en Mode"))

-----------------------------------------------------------
--------------------------[Save and Quit]------------------
-----------------------------------------------------------

map("n", "<leader>q", "<cmd>lua Snacks.bufdelete.delete(opts);Snacks.dashboard()<CR>", opt("[Q]uit to Dashboard"))

-----------------------------------------------------------
-----------------------[Typst Settings]--------------------
-----------------------------------------------------------
map("n", "<leader>tp", "<cmd>TypstPreview<CR>", opt("[T]ypst [P]review"))
map("n", "<leader>tu", "<cmd>TypstPreviewUpdate<CR>", opt("[T]ypst Preview [U]pdate"))

map("n", "<leader>gl", "<cmd>lua Snacks.lazygit()<CR>", opt("[G]it [L]azygit"))
