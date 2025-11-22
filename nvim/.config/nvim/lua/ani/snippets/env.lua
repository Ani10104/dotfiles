local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key
local snippet = ls.add_snippets

require('luasnip').config.setup { store_selection_keys = '<Tab>' }

ls.setup {
  enable_autosnippets = true,
  update_events = { 'TextChanged', 'TextChangedI' },
}

-- similar to global p! functions from UltiSnips

local function math()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

local function text()
  return not math()
end

local function env(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

--[
-- personal imports
--]
-- local tex = require 'luasnip-latex-snippets.luasnippets.tex.utils.conditions'
-- local make_condition = require('luasnip.extras.conditions').make_condition
-- local in_bullets_cond = make_condition(tex.in_bullets)
local line_begin = require('luasnip.extras.conditions.expand').line_begin

-- -- for TikZ environments. Note that you will need to define new helper functions with this setup
-- local function tikz()
--   return env 'tikzpicture'
-- end

local function enum()
  return env 'enumerate'
end

local function item()
  return env 'itemize'
end

local function list()
  return env 'list'
end

local function parts()
  return env 'parts'
end

local function align_nil()
  return env 'align'
end

local function align_star()
  return env 'align*'
end

snippet('tex', {
  s(
    'pac',
    fmt(
      [[
    \usepackage[<>]{<>}
    ]],
      {
        i(1, 'Options'),
        i(2, 'Packages'),
      },
      { delimiters = '<>' }
    )
  ),

  --Begin Environment

  s(
    'beg',
    fmt(
      [[
    \begin{<>}
      <>
    \end{<>}
    ]],
      {
        i(1, 'document'),
        i(0),
        rep(1),
      }, -- repeat node 1
      { delimiters = '<>' }
    )
  ),

  s(
    'enum',
    fmt(
      [[
    \begin{enumerate}<>
      \item <>
      <>
    \end{enumerate}<>
    ]],
      {
        c(1, {
          t '',
          t '[label = ]',
        }),
        i(2),
        i(3),
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = line_begin }
  ),
  -- s(
  --   'list',
  --   fmt(
  --     [[
  --   \begin{list}
  --     \item <>
  --     <>
  --   \end{list}<>
  --   ]],
  --     {
  --       i(1),
  --       i(2),
  --       i(0),
  --     },
  --     { delimiters = '<>' }
  --   )
  -- ),
  s(
    'item',
    fmt(
      [[
    \begin{itemize}
      \item <>
      <>
    \end{itemize}<>
    ]],
      {
        i(1),
        i(2),
        i(0),
      },
      { delimiters = '<>' }
    )
  ),

  s(
    'desc',
    fmt(
      [[
    \begin{description}
      \item[<>] <>
      <>
    \end{description}<>
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(0),
      },
      { delimiters = '<>' }
    )
  ),
})
