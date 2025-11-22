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
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

require('luasnip').config.setup { store_selection_keys = '<Tab>' }

ls.setup {
  enable_autosnippets = true,
  update_events = { 'TextChanged', 'TextChangedI' },
}

--custom conditions
local make_condition = require("luasnip.extras.conditions").make_condition
-- local in_bullets_cond = make_condition(tex.in_bullets)
local line_begin = conds_expand.line_begin

local function math()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

local function env(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

local function any_env()
  local envs = {
    -- Document structure
    'document', 'abstract', 'titlepage', 'appendix',
    -- Lists
    'itemize', 'enumerate', 'description', 'list',
    -- Floats
    'figure', 'figure*', 'table', 'table*',
    -- Math
    'equation', 'equation*', 'align', 'align*', 'gather', 'gather*',
    'multline', 'multline*', 'flalign', 'flalign*', 'alignat', 'alignat*',
    'split', 'cases', 'matrix', 'pmatrix', 'bmatrix', 'Bmatrix',
    'vmatrix', 'Vmatrix', 'smallmatrix', 'subequations',
    -- Theorems
    'theorem', 'lemma', 'corollary', 'proposition', 'definition',
    'example', 'proof', 'remark',
    -- Code
    'verbatim', 'verbatim*', 'lstlisting', 'minted',
    -- Text alignment
    'quote', 'quotation', 'verse', 'center', 'flushleft', 'flushright',
    -- Boxes
    'minipage', 'picture', 'framed', 'boxed',
    -- Arrays/tables
    'tabular', 'tabular*', 'longtable', 'array', 'tabbing'
  }

  for _, e in ipairs(envs) do
    if env(e) then return true end
  end

  return false
end

local function no_env()
  return not any_env()
end

local function doc()
  return env 'document'
end

local function itemize()
  return env 'itemize'
end
local preamble = make_condition(no_env)
local document = make_condition(doc)
local item = make_condition(itemize)

snippet('tex', {
	autosnippet(
		';pac',
		fmta([[
\usepackage{<>}
<>
    ]],
			{
				i(1, 'package'),
				i(0),
			}-- repeat node 1
		),
		{ condition = preamble * line_begin, show_condition = preamble}
	),
	autosnippet(
		';Pac',
		fmta([[
\usepackage[<>]{<>}
<>
    ]],
			{
				i(1, 'options'),
				i(2, 'package'),
				i(0),
			}-- repeat node 1
		),
		{ condition = preamble * line_begin, show_condition = preamble}
	),
	autosnippet(
		';beg',
		fmta([[
\begin{<>}

<>

\end{<>}
    ]],
			{
				i(1, 'document'),
				i(2),
				rep(1),
			}-- repeat node 1
		),
		{ condition = line_begin}
	),
	s(
		{ trig = 'sec', name = 'section', dscr = "\\section\\{\\}" },
		fmta([[
\section{<>}
<>
    ]],
			{
				i(1, 'section_name'),
				i(0),
			}
		),
		{ condition = line_begin * document, show_condition = document}
	),
	s(
		{ trig = 'ssec', name = 'subsection', dscr = "\\subsection\\{\\}" },
		fmta([[
\subsection{<>}
<>
    ]],
			{
				i(1, 'subsection_name'),
				i(0),
			}
		),
		{ condition = line_begin * document, show_condition = document}
	),
	s(
		{ trig = 'sssec', name = 'subsubsection', dscr = "\\subsubsection\\{\\}" },
		fmta([[
\subsubsection{<>}
<>
    ]],
			{
				i(1, 'subsubsection_name'),
				i(0),
			}
		),
		{ condition = line_begin * document, show_condition = document}
	),
	autosnippet(
		'ii',
		fmta([[
\item <>
    ]],
			{
				i(0),
			}-- repeat node 1
		),
		{ condition = item * line_begin, show_condition = item}
	),

})
