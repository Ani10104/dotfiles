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
	s(
		{
			trig = "snip",
			name = "add snippet",
			dscr = "This adds structure for snippets",
		},
		fmta(
			[[
		s(
			{
				trig = "<>",
				name = "<>",
				dscr = "<>",
			},
			fmta(
			<>
			{
				i(0),
			}
			),
		{ condition = <>, show_condition = <> }
		)<>
		]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(5),
				i(6),
				i(0),
			}
		),
		{ condition = line_begin }
	),
	s(
		{
			trig = "asnip",
			name = "add autosnippet",
			dscr = "This adds structure for autosnippets",
		},
		fmta(
			[[
		s(
			{
				trig = "<>",
				name = "<>",
				dscr = "<>",
				snippetType = "autosnippet",
			},
			fmta(
			<>
			{
				i(0),
			}
			),
		{ condition = <>, show_condition = <> }
		)<>
		]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(5),
				i(6),
				i(0),
			}
		),
		{ condition = line_begin }
	),
	s(
		{
			trig = "rsnip",
			name = "add regex-autosnippet",
			dscr = "This adds structure for regex-autosnippets",
		},
		fmta(
			[[
		s(
			{
				trig = "<>",
				regTrig = true,
				name = "<>",
				dscr = "<>",
				snippetType = "autosnippet",
			},
			fmta(
			<>
			{
				i(0),
			}
			),
		{ condition = <>, show_condition = <> }
		)<>
		]],
			{
				i(1),
				i(2),
				i(3),
				i(4),
				i(5),
				i(6),
				i(0),
			}
		),
		{ condition = line_begin }
	),
}
