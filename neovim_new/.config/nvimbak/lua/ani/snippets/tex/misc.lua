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
local myconds = require("ani.snippets.tex.utils.conditions")
local preamble = make_condition(myconds.no_env)
local documentt = make_condition(myconds.in_text)
local item = make_condition(myconds.in_bullets)
local math = make_condition(myconds.in_math)

-- Helpers for autosnippets: put snippetType on the snippet table
-- Example: s({ trig = "...", snippetType = "autosnippet" }, nodes, opts)

-- snippets for filetype 'tex'
-- return a table keyed by filetype so from_lua loader can pick them up
--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

return {
	s(
		{
			trig = "%*(.-)%*", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto bold font",
			dscr = "*text* expands to \\textbf{text}",
			snippetType = "autosnippet",
		},
		fmta("\\textbf{<>}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = document }
	),
	s(
		{
			trig = "%_(.-)%_", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto italics font",
			dscr = "_text_ expands to \\emph{text}",
			snippetType = "autosnippet",
		},
		fmta("\\emph{<>}", { f(function(_, snip)
			return snip.captures[1]
		end) }),
		{ condition = document }
	),
	s(
		{
			trig = "%#1 (.-)%:", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto expands to section",
			dscr = "#1 text expands to \\section{text}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
			\section{<>}
		]],
			{
				f(function(_, snip)
					return snip.captures[1]
				end),
			}
		),
		{ condition = document }
	),
	s(
		{
			trig = "%#2 (.-)%:", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto expands to subsection",
			dscr = "#2 text expands to \\subsection{text}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
			  \subsection{<>}
		]],
			{
				f(function(_, snip)
					return snip.captures[1]
				end),
			}
		),
		{ condition = document }
	),
	s(
		{
			trig = "%#3 (.-)%:", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto expands to susubbsection",
			dscr = "#3 text expands to \\subsubsection{text}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
			   \subsubsection{<>}
		]],
			{
				f(function(_, snip)
					return snip.captures[1]
				end),
			}
		),
		{ condition = document }
	),
	s(
		{
			trig = "%#4 (.-)%:", -- capture text between two *
			regTrig = true,
			wordTrig = false,
			name = "auto expands to paragraph",
			dscr = "#4 text expands to \\paragraph{text}",
			snippetType = "autosnippet",
		},
		fmta(
			[[
			   \paragraph{<>}
		]],
			{
				f(function(_, snip)
					return snip.captures[1]
				end),
			}
		),
		{ condition = document }
	),
}
