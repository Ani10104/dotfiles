---@diagnostic disable: undefined-global
-- ~/.config/nvim/lua/ani/snippets/tex.lua
local ls = require("luasnip")
-- extras
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local line_begin = require("luasnip.extras.conditions.expand").line_begin
local make_condition = require("luasnip.extras.conditions").make_condition

-- config (modern single call)
ls.config.set_config({
	history = true, -- keep around last snippet local to jump back
	enable_autosnippets = true,
	store_selection_keys = "<Tab>",
	update_events = "TextChanged,TextChangedI",
})

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
-- -- vimtex helpers (keep these as you had them)
-- local function math()
-- 	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
-- end
--
-- local function env(name)
-- 	local is_inside = vim.fn["vimtex#env#is_inside"](name)
-- 	return (is_inside[1] > 0 and is_inside[2] > 0)
-- end
--
-- local function any_env()
-- 	local envs = {
-- 		-- Document structure
-- 		"document",
-- 		"abstract",
-- 		"titlepage",
-- 		"appendix",
-- 		-- Lists
-- 		"itemize",
-- 		"enumerate",
-- 		"description",
-- 		"list",
-- 		-- Floats
-- 		"figure",
-- 		"figure*",
-- 		"table",
-- 		"table*",
-- 		-- Math
-- 		"equation",
-- 		"equation*",
-- 		"align",
-- 		"align*",
-- 		"gather",
-- 		"gather*",
-- 		"multline",
-- 		"multline*",
-- 		"flalign",
-- 		"flalign*",
-- 		"alignat",
-- 		"alignat*",
-- 		"split",
-- 		"cases",
-- 		"matrix",
-- 		"pmatrix",
-- 		"bmatrix",
-- 		"Bmatrix",
-- 		"vmatrix",
-- 		"Vmatrix",
-- 		"smallmatrix",
-- 		"subequations",
-- 		-- Theorems
-- 		"theorem",
-- 		"lemma",
-- 		"corollary",
-- 		"proposition",
-- 		"definition",
-- 		"example",
-- 		"proof",
-- 		"remark",
-- 		-- Code
-- 		"verbatim",
-- 		"verbatim*",
-- 		"lstlisting",
-- 		"minted",
-- 		-- Text alignment
-- 		"quote",
-- 		"quotation",
-- 		"verse",
-- 		"center",
-- 		"flushleft",
-- 		"flushright",
-- 		-- Boxes
-- 		"minipage",
-- 		"picture",
-- 		"framed",
-- 		"boxed",
-- 		-- Arrays/tables
-- 		"tabular",
-- 		"tabular*",
-- 		"longtable",
-- 		"array",
-- 		"tabbing",
-- 	}
--
-- 	for _, e in ipairs(envs) do
-- 		if env(e) then
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
--
-- local function no_env()
-- 	return not any_env()
-- end
-- local function doc()
-- 	return env("document")
-- end
-- local function itemize()
-- 	return env("itemize")
-- end
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------
---
local myconds = require("ani.snippets.tex.utils.conditions")
local preamble = make_condition(myconds.no_env)
local document = make_condition(myconds.in_text)
local item = make_condition(myconds.in_bullets)
local math = make_condition(myconds.in_math)

-- Helpers for autosnippets: put snippetType on the snippet table
-- Example: s({ trig = "...", snippetType = "autosnippet" }, nodes, opts)

-- snippets for filetype 'tex'
-- return a table keyed by filetype so from_lua loader can pick them up
return {
	-- \usepackage{<pkg>}
	s(
		{
			trig = ";pac",
			name = "usepackage",
			dscr = "Insert \\usepackage{...}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \usepackage{<>}
        <>
      ]],
			{ i(1, "package"), i(0) }
		),
		{ condition = preamble * line_begin, show_condition = preamble }
	),

	-- \usepackage[<opts>]{<pkg>}
	s(
		{
			trig = ";Pac",
			name = "usepackage_with_options",
			dscr = "Insert \\usepackage[options]{package}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \usepackage[<>]{<>}
        <>
      ]],
			{ i(1, "options"), i(2, "package"), i(0) }
		),
		{ condition = preamble * line_begin, show_condition = preamble }
	),

	-- \begin{<env>}...\end{<env>}
	s(
		{
			trig = ";beg",
			name = "environment_block",
			dscr = "Insert \\begin{env} ... \\end{env}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
        \begin{<>}

        <>

        \end{<>}
      ]],
			{ i(1, "environment"), i(2), rep(1) }
		),
		{ condition = line_begin }
	),

	-- \section{...}
	s(
		{
			trig = "sec",
			name = "section",
			dscr = "Insert \\section{}",
		},
		fmta(
			[[
        \section{<>}
        <>
      ]],
			{ i(1, "section_name"), i(0) }
		),
		{ condition = line_begin * document, show_condition = document }
	),

	-- \subsection{...}
	s(
		{
			trig = "ssec",
			name = "subsection",
			dscr = "Insert \\subsection{}",
		},
		fmta(
			[[
        \subsection{<>}
        <>
      ]],
			{ i(1, "subsection_name"), i(0) }
		),
		{ condition = line_begin * document, show_condition = document }
	),

	-- \subsubsection{...}
	s(
		{
			trig = "sssec",
			name = "subsubsection",
			dscr = "Insert \\subsubsection{}",
		},
		fmta(
			[[
        \subsubsection{<>}
        <>
      ]],
			{ i(1, "subsubsection_name"), i(0) }
		),
		{ condition = line_begin * document, show_condition = document }
	),

	-- \item
	s({
		trig = "- ",
		name = "item",
		dscr = "Insert \\item",
		snippetType = "autosnippet",
	}, fmta([[ \item <> ]], { i(0) }), { condition = item * line_begin, show_condition = item }),

	s({
		trig = "//",
		name = "fraction",
		dscr = "Expand to use fraction",
		snippetType = "autosnippet",
	}, fmta([[ \frac{<>}{<>} <> ]], { i(1), i(2), i(0) }), { condition = math, show_condition = math }),
	s(
		{
			trig = ";beg",
			name = "Begin environment",
			dscr = "It expands sto \\begin{env} and \\end{env}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
\begin{<>}
<>
\end{<>}
]],
			{
				i(1),
				i(0),
				rep(1),
			}
		),
		{ condition = document, show_condition = document }
	),

	s(
		{
			trig = "(%a)(%d)",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[<>_<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
		}),
		{ condition = math }
	),
}
