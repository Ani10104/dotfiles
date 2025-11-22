-- [[ install `lazy.nvim` plugin manager ]]
--    see `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local imports = {}
for _, plugin_group in ipairs(AniVim.plugin_list) do
  table.insert(imports, { import = plugin_group })
end
--
-- note: here is where you install your plugins.
require('lazy').setup({
  spec = imports,
  --colorscheme that will be used when installing plugins.
  install = { colorscheme = { AniVim.colorscheme } },
  checker = {enabled = true}
},
  {
    ui = {
      -- if you are using a nerd font: set icons to an empty table which will use the
      -- default lazy.nvim defined nerd font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  })

-- the line beneath this is called `modeline`. see `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
