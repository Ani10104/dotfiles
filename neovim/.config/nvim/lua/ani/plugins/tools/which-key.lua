return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 200
  end,
  opts = {
    setup = {
      show_help = true,
      preset = 'modern',
      plugins = {
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
          marks = false,
          registers = false,
          spelling = {
            enabled = false,
            suggestions = 10,
          },
        },
      },
      -- Deprecated key_labels replaced with `replace`
      replace = {
        -- e.g. ['<space>'] = 'SPC',
      },
      triggers = {
        { '<leader>', mode = { 'n', 'v' } },
      },
      icons = {
        breadcrumb = '»',
        separator = '➜',
        group = '+',
      },
      delay = 200, -- use delay instead of triggers_nowait
      -- Deprecated ignore_missing replaced with a filter function
      filter = function(mapping)
        return mapping.desc ~= nil
      end,
      -- Removed deprecated triggers_blacklist
      disable = {
        buftypes = {},
        filetypes = {},
      },
    },
    defaults = {
      -- buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
      -- silent = true, -- use `silent` when creating keymaps
      -- noremap = true, -- use `noremap` when creating keymaps
      -- nowait = true, -- use `nowait` when creating keymaps
      -- prefix = '<leader>',
      -- mode = { 'n', 'v' },
      -- a = {
      --   name = 'ACTIONS',
      --   h = { '<cmd>LocalHighlightToggle<CR>', 'highlight' }, -- l = { "<cmd>lua vim.g.cmptoggle = not vim.g.cmptoggle<CR>", "LSP" },
      --   -- m = { "<cmd>MarkdownPreview<CR>", "markdown preview" },
      -- },
      -- c = { '<cmd>vert sb<CR>', 'create split' },
      -- -- k = { "<cmd>clo<CR>", "kill split" },
      -- d = { '<cmd>update! | bdelete!<CR>', 'delete buffer' },
      -- e = {
      --   function()
      --     require('snacks').explorer()
      --   end,
      --   'Open Explorer',
      -- },
      -- j = { '<cmd>clo<CR>', 'drop split' },
      -- -- h = { "<cmd>Alpha<CR>", "home" },
      -- -- i = { '<cmd>VimtexTocOpen<CR>', 'index' },
      -- k = { '<cmd>on<CR>', 'max split' },
      -- q = { '<cmd>wa! | qa!<CR>', 'quit' },
      -- r = {
      --   function()
      --     Snacks.picker.recent()
      --   end,
      --   'Recent',
      -- },
      -- R = {
      --   function()
      --     Snacks.picker.registers()
      --   end,
      --   'Registers',
      -- },
      -- -- u = { '<cmd>Telescope undo<CR>', 'undo' },
      -- w = { '<cmd>wa!<CR>', 'write' },
      -- z = {
      --   function()
      --     require('snacks').zen()
      --   end,
      --   'Toggle Zen Mode',
      -- },
      -- Z = {
      --   function()
      --     require('snacks').zen.zoom()
      --   end,
      --   'Toggle Zoom',
      -- },
      -- g = {
      --   name = 'Git',
      --   f = {
      --     function()
      --       Snacks.picker.git_files()
      --     end,
      --     'Find Git Files',
      --   },
      -- },
      -- f = {
      --   name = 'FIND',
      --   a = {
      --     function()
      --       Snacks.picker.autocmds()
      --     end,
      --     'Autocmds',
      --   },
      --   b = {
      --     function()
      --       require('snacks').picker.buffers()
      --     end,
      --     'Buffers',
      --   },
      --   k = { '<cmd>Telescope keymaps<CR>', 'keymaps' },
      --   u = {
      --     function()
      --       Snacks.picker.undo()
      --     end,
      --     'Undo History',
      --   },
      --   c = {
      --     function()
      --       Snacks.picker.colorschemes()
      --     end,
      --     'Colorschemes',
      --   },
      --   g = {
      --     function()
      --       Snacks.picker.grep()
      --     end,
      --     'Grep',
      --   },
      --   G = {
      --     function()
      --       Snacks.picker.grep_word()
      --     end,
      --     'Grep Visual',
      --   },
      --   h = {
      --     function()
      --       Snacks.picker.search_history()
      --     end,
      --     'Search History',
      --   },
      --   H = {
      --     function()
      --       Snacks.picker.highlights()
      --     end,
      --     'Highlights',
      --   },
      -- },
      -- -- LIST MAPPINGS
      -- L = {
      --   name = 'LIST',
      --   c = { '<cmd>lua HandleCheckbox()<CR>', 'checkbox' },
      --   -- c = { "<cmd>lua require('autolist').invert()<CR>", "checkbox" },
      --   -- x = { "<cmd>lua handle_checkbox()<CR>", "checkbox" },
      --   -- c = { "<cmd>AutolistToggleCheckbox<CR>", "checkmark" },
      --   n = { '<cmd>AutolistCycleNext<CR>', 'next' },
      --   p = { '<cmd>AutolistCyclePrev<CR>', 'previous' },
      --   r = { '<cmd>AutolistRecalculate<CR>', 'reorder' },
      -- },
      -- l = {
      --   name = 'LSP',
      --   b = { '<cmd>Telescope diagnostics bufnr=0<CR>', 'buffer diagnostics' },
      --   c = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code action' },
      --   d = { '<cmd>Telescope lsp_definitions<CR>', 'definition' },
      --   D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration' },
      --   h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'help' },
      --   i = { '<cmd>Telescope lsp_implementations<CR>', 'implementations' },
      --   k = { '<cmd>LspStop<CR>', 'kill lsp' },
      --   l = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'line diagnostics' },
      --   n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'next diagnostic' },
      --   p = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'previous diagnostic' },
      --   r = { '<cmd>Telescope lsp_references<CR>', 'references' },
      --   s = { '<cmd>LspRestart<CR>', 'restart lsp' },
      --   t = { '<cmd>LspStart<CR>', 'start lsp' },
      --   R = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'rename' },
      --   -- T = { "<cmd>Telescope lsp_type_definitions<CR>", "type definition" },
      -- },
      -- n = {
      --   name = 'newline',
      --   d = { 'o<Esc>k', 'downline' },
      --   u = { 'O<Esc>j', 'upline' },
      -- },
      -- S = {
      --   name = 'SESSIONS',
      --   s = { '<cmd>SessionManager save_current_session<CR>', 'save' },
      --   d = { '<cmd>SessionManager delete_session<CR>', 'delete' },
      --   l = { '<cmd>SessionManager load_session<CR>', 'load' },
      -- },
      -- N = {
      --   function()
      --     Snacks.picker.notifications()
      --   end,
      --   'Notification History',
      -- },
      --
      -- s = {
      --   name = 'SURROUND',
      --   s = { '<Plug>(nvim-surround-normal)', 'surround' },
      --   d = { '<Plug>(nvim-surround-delete)', 'delete' },
      --   c = { '<Plug>(nvim-surround-change)', 'change' },
      -- },
    },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts.setup)
    wk.add {
      {
        mode = { 'n', 'v' }, -- NORMAL and VISUAL mode
        { '<leader>f', group = 'file' }, -- group
      },
    }
    if not vim.tbl_isempty(opts.defaults) then
      LazyVim.warn 'which-key: opts.defaults is deprecated. Please use opts.spec instead.'
      wk.register(opts.defaults)
    end
  end,
}
