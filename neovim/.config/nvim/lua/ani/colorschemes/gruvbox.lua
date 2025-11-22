return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000, -- Ensures Gruvbox loads before other plugins
  config = function()
    require('gruvbox').setup {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- Invert background for search, diffs, statuslines, and errors
      contrast = 'soft', -- Options: "hard", "soft", or empty string
      palette_overrides = {},
      overrides = {},
      dim_inactive = false,
      transparent_mode = true,
    }
    vim.o.background = 'dark' -- Set to "light" for light mode
    vim.cmd 'colorscheme gruvbox'
  end,
}
