return {
  {
    'neanias/everforest-nvim',
    version = false, -- Use the latest commit
    lazy = false, -- Load the plugin during startup
    priority = 1000, -- Ensure it loads before other plugins
    config = function()
      require('everforest').setup {
        -- Place your configuration options here
        background = 'hard', -- Options: "soft", "medium", "hard"
        transparent_background_level = 2,
        italics = true,
        -- Add other customization options as needed
      }
      vim.cmd 'colorscheme everforest'
    end,
  },
}
