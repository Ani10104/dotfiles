return {
  'folke/tokyonight.nvim',
  priority = 1000,
  init = function()
    -- Set transparency before applying the colorscheme
    vim.g.tokyonight_disable_background = true
    -- Apply the colorscheme
    vim.cmd.colorscheme 'tokyonight-storm'

    -- Optional: adjust highlights (e.g., remove italics from comments)
    vim.cmd.hi 'Comment gui=none'
  end,
}
