-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_user_command("LatexNewProject", function(opts)
  require("ani.latex_project").create_latex_project(opts.args)
end, {
  nargs = 1,
  complete = "file",
})

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "texStyleBold", { fg = "#badfd7", bold = true })
    vim.api.nvim_set_hl(0, "texStyleItal", { fg = "#f7e3db", bold = false })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex", "latex", "org" },
  callback = function()
    vim.lsp.start({
      name = "harper-ls",
      cmd = { "harper-ls", "--stdio" },
      root_dir = vim.fn.getcwd(),
    })
  end,
})
