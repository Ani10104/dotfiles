return {

  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    -- "nvim-treesitter/nvim-treesitter-textobjects",
    'JoosepAlviste/nvim-ts-context-commentstring',
    'windwp/nvim-ts-autotag',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      -- enable syntax highlighting
      highlight = {
        enable = true,
        disable = { 'css', 'latex', 'markdown', 'cls' }, -- list of language that will be disabled
        -- additional_vim_regex_highlighting = { 'org' }, -- for orgmode
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      autotag = {
        enable = false,
      },
      -- ensure these language parsers are installed
      ensure_installed = {
        'html',
        'bash',
        'lua',
        'vim',
        'gitignore',
        'query',
        'vim',
        'c',
        'bibtex',
        'vimdoc',
        -- "latex",
        -- "javascript",
        -- "typescript",
        -- "tsx",
        -- "css",
        -- "prisma",
        -- "markdown",
        -- "markdown_inline",
        -- "svelte",
        -- "graphql",
        -- "dockerfile",
        -- "perl",
      },
      auto_install = true,
      ignore_install = { 'latex','org' }, -- List of parsers to ignore installing
      autopairs = {
        enable = true,
      },
      -- indent = { enable = false, disable = { "latex", "python", "css" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-n>',
          node_incremental = '<C-n>',
          scope_incremental = false,
          node_decremental = '<C-p>',
        },
      },
    }

    -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
    require('ts_context_commentstring').setup {}
  end,
}
