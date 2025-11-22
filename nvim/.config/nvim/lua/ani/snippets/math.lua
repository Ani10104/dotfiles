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
-------------------------------------------------------

-- Helper function to check if inside double brackets
-- local function inside_second_brackets()
--   -- Get the current line of the cursor
--   local line = vim.api.nvim_get_current_line()
--   -- Get the cursor position (1-based indexing)
--   local col = vim.api.nvim_win_get_cursor(0)[2]
--
--   -- Look for double brackets `[[` before the cursor and closing brackets after
--   return line:sub(1, col):find '\\begin{[^}]*' and line:sub(col + 1):find '%}'
-- end

--[[
--  ███╗   ██╗ ██████╗ ██████╗ ███╗   ███╗ █████╗ ██╗         
    ████╗  ██║██╔═══██╗██╔══██╗████╗ ████║██╔══██╗██║         
    ██╔██╗ ██║██║   ██║██████╔╝██╔████╔██║███████║██║         
    ██║╚██╗██║██║   ██║██╔══██╗██║╚██╔╝██║██╔══██║██║         
    ██║ ╚████║╚██████╔╝██║  ██║██║ ╚═╝ ██║██║  ██║███████╗    
    ╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝    
███████╗███╗   ██╗██╗██████╗ ██████╗ ███████╗████████╗███████╗
██╔════╝████╗  ██║██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
███████╗██╔██╗ ██║██║██████╔╝██████╔╝█████╗     ██║   ███████╗
╚════██║██║╚██╗██║██║██╔═══╝ ██╔═══╝ ██╔══╝     ██║   ╚════██║
███████║██║ ╚████║██║██║     ██║     ███████╗   ██║   ███████║
╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝     ╚══════╝   ╚═╝   ╚══════╝
                                                              
--]]

--[[
--
--
--............█████╗ ██╗   ██╗████████╗ ██████╗
.............██╔══██╗██║   ██║╚══██╔══╝██╔═══██╗
.............███████║██║   ██║   ██║   ██║   ██║
.............██╔══██║██║   ██║   ██║   ██║   ██║
.............██║  ██║╚██████╔╝   ██║   ╚██████╔╝
.............╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝
███████╗███╗   ██╗██╗██████╗ ██████╗ ███████╗████████╗███████╗
██╔════╝████╗  ██║██║██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝
███████╗██╔██╗ ██║██║██████╔╝██████╔╝█████╗     ██║   ███████╗
╚════██║██║╚██╗██║██║██╔═══╝ ██╔═══╝ ██╔══╝     ██║   ╚════██║
███████║██║ ╚████║██║██║     ██║     ███████╗   ██║   ███████║
╚══════╝╚═╝  ╚═══╝╚═╝╚═╝     ╚═╝     ╚══════╝   ╚═╝   ╚══════╝
--
--
--]]
snippet('tex', {

  -- s(
  --   '-beg',
  --   fmt(
  --     [[
  --   \begin{<>}
  --     <>
  --   \end{<>}
  --   ]],
  --     {
  --       i(1, 'document'),
  --       i(0),
  --       rep(1),
  --     }, -- repeat node 1
  --     { delimiters = '<>' }
  --   ),
  --   { condition = line_begin }
  -- ),

  s(
    '-ali',
    fmt(
      [[
    \begin{align<>}
      <><>
    \end{align<>}
    ]],
      {
        i(1),
        f(function(args, snip)
          local res, env = {}, snip.env
          for _, val in ipairs(env.LS_SELECT_RAW) do
            table.insert(res, val)
          end
          return res
        end, {}),
        i(2),
        rep(1),
      }, -- repeat node 1
      { delimiters = '<>' }
    ),
    { condition = line_begin }
  ),

  s(
    '...',
    fmt(
      [[
      \ldots <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    )
  ),

  s(
    { trig = '**', wordTrig = false, name = 'multiply', dscr = '\times' },
    fmt(
      [[
      \times <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  -- s({ trig = '*', wordTrig = false, name = 'multiply', dscr = '\times' }, t ' \\times ', i(0), { condition = math }),

  -- sub super scripts

  s(
    { trig = 'sub', name = 'subscript manual', dscr = '_{}' },
    fmt([[{<>}_{<>}]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = '(%a)(%d)', regTrig = true, name = 'auto subscript', dscr = 'hi' },
    fmt(
      [[<>_<>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),
  s(
    { trig = '(%a)_(%d%d)', regTrig = true, name = 'auto subscript 2', dscr = 'auto subscript for 2+ digits' },
    fmt(
      [[<>_{<>}]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),
  -- visual brackets
  s(
    { trig = 'lb3', name = 'left right', dscr = 'left right' },
    fmt([[\left[<><>\right]<>]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(1),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'lb2', name = 'left right', dscr = 'left right' },
    fmt([[\left\{<><>\right\}<>]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(1),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'lb1', name = 'left right', dscr = 'left right' },
    fmt([[\left(<><>\right)<>]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(1),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),
  -- mint inline code
  s(
    { trig = 'qw', name = 'inline code', dscr = 'inline code, ft escape' },
    fmt([[\mintinline{<>}<>]], { i(1, 'text'), c(2, { sn(nil, { t '{', i(1), t '}' }), sn(nil, { t '|', i(1), t '|' }) }) }, { delimiters = '<>' })
  ),

  -- fraction
  -- visual fraction
  s(
    { trig = '//', name = 'left right', dscr = 'left right' },
    fmt([[\frac{<><>}{<>} <>]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(1),
      i(2),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),

  s(
    'f_name',
    f(function()
      local filename = vim.fn.expand '%:t:r'
      return (filename:gsub('_', ' '):gsub('(%a)([%w]*)', function(first, rest)
        return first:upper() .. rest:lower()
      end))
    end)
  ),

  -- s(
  --
  --   { trig = '//', name = 'fraction norm', dscr = 'normally expand fraction' },
  --   fmt(
  --     [[
  --   \frac{<>}{<>} <>
  --     ]],
  --     {
  --       i(1),
  --       i(2),
  --       i(0),
  --     },
  --     { delimiters = '<>' }
  --   ),
  --   { condition = math, show_condition = math }
  -- ),

  s(
    { trig = '([^%s()%[%]{}]+)//([^%s()%[%]{}]+)', regTrig = true, name = 'auto fraction', dscr = 'auto enters digits inside fraction' },
    fmt(
      [[\frac{<>}{<><>} <>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end), i(1), i(0) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  --list and  enum items
  s(
    { trig = '--', name = 'auto item', dscr = 'auto enters digits inside fraction' },
    fmt(
      [[
      \item <>
      <>
      ]],
      { i(1), i(0) },
      { delimiters = '<>' }
    ),
    { condition = enum * line_begin }
  ),

  s(
    { trig = '--', name = 'auto item', dscr = 'auto enters digits inside fraction' },
    fmt(
      [[
      \item <>
      <>
      ]],
      { i(1), i(0) },
      { delimiters = '<>' }
    ),
    { condition = list * line_begin }
  ),

  s(
    { trig = '--', name = 'auto item', dscr = 'auto enters digits inside environment' },
    fmt(
      [[
      \item <>
      <>
      ]],
      { i(1), i(0) },
      { delimiters = '<>' }
    ),
    { condition = item * line_begin }
  ),

  s(
    { trig = '(%d)-', regTrig = true, name = 'bullet points', dscr = 'normally expand items' },
    fmt(
      [[
    \part[<>] <>
      ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = parts * line_begin }
  ),

  -- math snips
  s(
    { trig = '(%d)([%+%-%=%^])', regTrig = true, name = 'auto space', dscr = 'automatically adds space after a math operation', wordTrig = false },
    fmt(
      [[<> <>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = '(%a)([%+%-%=%^])', regTrig = true, name = 'auto space', dscr = 'automatically adds space after a math operation', wordTrig = false },
    fmt(
      [[<> <>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = '([%+%-%=%^])(%d)', regTrig = true, name = 'auto space', dscr = 'automatically adds space after a math operation', wordTrig = false },
    fmt(
      [[<> <>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = '([%+%-%=%^])(%a)', regTrig = true, name = 'auto space', dscr = 'automatically adds space after a math operation', wordTrig = false },
    fmt(
      [[<> <>]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = '=>', name = 'Rightarrow', dscr = '=>' },
    fmt(
      [[
        \Rightarrow <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = '==', name = 'Rightarrow', dscr = '=>' },
    fmt(
      [[
      &= <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = align_nil and align_star }
  ),

  --inline and other math modes
  s(
    { trig = 'mk', name = 'inline math', dscr = '$ math $' },
    fmt(
      [[
    $ <> $<><>
      ]],
      {
        i(1),
        f(function(args, snip)
          -- Check if the second input exists and whether the first character requires a space
          local second_input = args[1][1]
          if second_input ~= '' and not second_input:match '^[,%.%?%- ]' then
            return ' ' -- Add a space if the next character isn't ',', '.', '?', '-', or ' '
          else
            return '' -- No space otherwise
          end
        end, { 2 }),
        i(2),
      },
      { delimiters = '<>' }
    )
  ),

  s(
    { trig = 'dm', name = 'display math', dscr = '$$ $$' },
    fmt(
      [[
    \[ <> \]<>
      ]],
      {
        f(function(args, snip)
          local res, env = {}, snip.env
          for _, val in ipairs(env.LS_SELECT_RAW) do
            table.insert(res, val)
          end
          return res
        end, {}),
        i(0),
      },
      { delimiters = '<>' }
    )
  ),

  s(
    { trig = 'dd', name = 'left right', dscr = 'left right' },
    fmt([[\dd{<>} <>]], {
      f(function(args, snip)
        local res, env = {}, snip.env
        for _, val in ipairs(env.LS_SELECT_RAW) do
          table.insert(res, val)
        end
        return res
      end, {}),
      i(0),
    }, { delimiters = '<>' }),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'd/d(%a)', regTrig = true, name = 'differential single', dscr = 'dx', wordTrig = false },
    fmt(
      [[
        \dv{<>}( <> )<>
        ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), i(1), i(0) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = 'd(%S)/d(%S)', regTrig = true, name = 'differential single', dscr = 'dx', wordTrig = false },
    fmt(
      [[
        \dv{<>}{<>}<>
        ]],
      { f(function(_, snip)
        return snip.captures[1]
      end), f(function(_, snip)
        return snip.captures[2]
      end), i(0) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = 'd%((.-)%)/d(%a)', regTrig = true, name = 'differential single', dscr = 'dx', wordTrig = false },
    fmt(
      [[
        \dv{<>}(<>)<>
        ]],
      { f(function(_, snip)
        return snip.captures[2]
      end), f(function(_, snip)
        return snip.captures[1]
      end), i(0) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  s(
    { trig = 'd%[(.-)%]/d(%a)', regTrig = true, name = 'differential single', dscr = 'dx', wordTrig = false },
    fmt(
      [[
        \dv{<>}\qty[<>]<>
        ]],
      { f(function(_, snip)
        return snip.captures[2]
      end), f(function(_, snip)
        return snip.captures[1]
      end), i(0) },
      { delimiters = '<>' }
    ),
    { condition = math }
  ),

  --square, cube and to the powers
  s(
    { trig = 'sq', name = 'square', dscr = '^2', wordTrig = false },
    fmt(
      [[
        ^2 <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'cb', name = 'cube', dscr = '^3', wordTrig = false },
    fmt(
      [[
        ^3 <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'inv', name = 'inverse', dscr = '^{-1}', wordTrig = false },
    fmt(
      [[
        ^{-1} <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),

  s(
    { trig = 'tp', name = 'to the power', dscr = '^{}', wordTrig = false },
    fmt(
      [[
        ^{<>} <>
      ]],
      {
        i(1),
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),
  s(
    { trig = 'comp', name = 'complement', dscr = '^c', wordTrig = false },
    fmt(
      [[
        ^c <>
      ]],
      {
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = math, show_condition = math }
  ),
  -- s({
  --   trig = 'aln', -- trigger
  --   dscr = 'Expands only inside double brackets', -- description
  -- }, {
  --   t 'align',
  -- }, {
  --   condition = inside_second_brackets,
  --   show_condition = inside_second_brackets, -- condition for expansion
  -- }),
  --
  -- s({
  --   trig = 'al*', -- trigger
  --   dscr = 'Expands only inside double brackets', -- description
  -- }, {
  --   t 'align*',
  -- }, {
  --   condition = inside_second_brackets,
  --   show_condition = inside_second_brackets, -- condition for expansion
  -- }),

  -- hat
  postfix('hat', { l('\\hat{' .. l.POSTFIX_MATCH .. '}') }, { condition = math }), -- lambdas are basically function nodes but perform very simple tasks, e.g. string concatenation/modification
}, {
  type = 'autosnippets',
  key = 'all_auto',
})
--Hellow
