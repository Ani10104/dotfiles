--BoldFont
vim.keymap.set('v', '<C-b>', 'c\\textbf{<C-r>"}<esc>', { desc = 'BoldFont' })

--Emphasis
vim.keymap.set('v', '<C-E>', 'c\\emph{<C-r>"}<esc>', { desc = 'Emphasis' })

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
-- Enable syntax concealing for LaTeX files
vim.opt_local.conceallevel = 2

-- Configure VimTeX conceal options
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  ligatures = 1,
  cites = 1,
  fancy = 1,
  spacing = 1,
  greek = 1,
  math_bounds = 1,
  math_delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 0,
  styles = 1,
}

