local map = vim.keymap.set
local opts = { noremap = true, silent = true }


--description with opts
local function opt(desc)
  return vim.tbl_extend("force", opts, { desc = desc })
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


--  Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
map('n', '<leader>c', '<cmd>vert sb<CR>', { desc = 'create split' })
map('n', '<leader>j', '<cmd>clo<CR>', { desc = 'drop split' })
map('n', '<leader>k', '<cmd>on<CR>', { desc = 'max split' })

--Save using F1
map('n', '<F1>', "<cmd>wa!<CR>", opt('Save'))
map('i', '<F1>', '<Esc><cmd>wa!<CR>', opt('Save in Insert'))
map('n', '<F2>', "<cmd>VimtexCompile<CR>", {desc = 'VimCompile'})
map('n', '<F3>', "<cmd>VimtexView<CR>", {desc = 'VimView'})

map('n', '<leader>r', function()
	Snacks.picker.recent()
end, opt('Recent'))

vim.keymap.set("n", "<leader>sm", function()
  Snacks.image.hover()
end, { desc = "Snacks: Render inline math" })
map('n', '<leader>fk', function()
	Snacks.picker.keymaps { layout = 'ivy' }
end, { desc = 'keymaps' })
map("n", "<leader>vd", "<Plug>(vimtex-env-delete)", { desc = "Delete LaTeX Environment" })

-- Function to toggle all folds
local function toggle_all_folds()
  local current_foldlevel = vim.opt.foldlevel:get()
  if current_foldlevel == 0 then
    vim.cmd('normal! zR')  -- Open all folds
  else
    vim.cmd('normal! zM')  -- Close all folds
  end
end
-- Map <F9> to toggle all folds
map('n', '<F9>',function ()
	toggle_all_folds()
end, opt('Toggle All Folds'))


-- 'ai' and 'ii' for the item text object
map({ 'o', 'v' }, 'ai', '<Plug>(vimtex-am)', opt('Around Items'))
map({ 'o', 'v' }, 'ii', '<Plug>(vimtex-im)', opt('Inside Items'))

--'am' and 'im' for the inline math text object
map({ 'o', 'v' }, 'am', '<Plug>(vimtex-a$)', opt('Around Math'))
map({ 'o', 'v' }, 'im', '<Plug>(vimtex-i$)', opt('Inside Math'))
vim.keymap.set('n', '-', function()
  if not MiniFiles.close() then
		local buf_name = vim.api.nvim_buf_get_name(0)
		local dir_name = vim.fn.fnamemodify(buf_name, ":p:h")
		if vim.fn.filereadable(buf_name) == 1 then
			-- Pass the full file path to highlight the file
			require("mini.files").open(buf_name, true)
		elseif vim.fn.isdirectory(dir_name) == 1 then
			-- If the directory exists but the file doesn't, open the directory
			require("mini.files").open(dir_name, true)
		else
			-- If neither exists, fallback to the current working directory
			require("mini.files").open(vim.uv.cwd(), true)
		end
  end
end, { desc = 'Toggle MiniFiles Explorer' })


map('n', '<M-h>', ':bprevious<CR>', opt('Previous buffer' ))
map('n', '<M-l>', ':bnext<CR>', opt('Previous buffer' ))
map('n', '<leader>bd', ':bdelete<CR>', opt('Previous buffer' ))
