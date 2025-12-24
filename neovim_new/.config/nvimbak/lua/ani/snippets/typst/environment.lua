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

-- local myconds = require("ani.snippets.tex.utils.conditions")

local conds = require("luasnip.extras.conditions")

local in_math = function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	local before = line:sub(1, col)
	local dollar_count = select(2, before:gsub("%$", ""))

	return dollar_count % 2 == 1
end

local math = make_condition(in_math)

return {
	s(
		{
			trig = "mk",
			regTrig = true,
			name = "Inline math mode",
			dscr = "Expands to $$",
			snippetType = "autosnippet",
		},
		fmta([[$<>$ <>]], {
			i(1),
			i(0),
		})
	),
	s(
		{
			trig = "dmk",
			name = "Display math mode",
			dscr = "Expands to $  $",
			snippetType = "autosnippet",
		},
		fmta(
			[[
		$ <> $ <>
		]],
			{
				i(1),
				i(0),
			}
		)
	),
	s(
		{
			trig = "([%a%d]+) tp",
			regTrig = true,
			name = "auto superscript",
			dscr = "adds ^{superscript}",
			snippetType = "autosnippet",
		},
		fmta([[<>^(<>)<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "tp",
			name = "auto square",
			dscr = "adds ^{square}",
			snippetType = "autosnippet",
		},
		fmta([[^(<>)<>]], {
			i(1),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "sq",
			name = "auto square",
			dscr = "adds ^{square}",
			snippetType = "autosnippet",
		},
		fmta([[^2<>]], {
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "cu",
			name = "auto cube",
			dscr = "adds ^{cube}",
			snippetType = "autosnippet",
		},
		fmta([[^3<>]], {
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "([%a%d]+) ss",
			regTrig = true,
			name = "auto subscript",
			dscr = "adds _{subscript}",
			snippetType = "autosnippet",
		},
		fmta([[<>_(<>)<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "(%a+)(%d+)%s",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[<>_(<>) <>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "ket",
			name = "ket",
			dscr = "Ket notation",
			snippetType = "autosnippet",
		},
		fmta(
			[[
		chevron.r <>
		]],
			{
				i(0),
			}
		),
		{ condition = math }
	),
	s(
		{
			trig = "hbar",
			name = "hbar",
			dscr = "Plank's Constant",
			snippetType = "autosnippet",
		},
		fmta(
			[[
		planck <>
		]],
			{
				i(0),
			}
		),
		{ condition = math }
	),
	s(
		{
			trig = "int",
			name = "integral",
			dscr = "Integration",
			snippetType = "autosnippet",
		},
		fmta(
			[[
		integral<>
		]],
			{
				i(0),
			}
		),
		{ condition = math }
	),
	s(
		{
			trig = "del (%a+)%s",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[(partial  <>) <>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "d([%a%d]+)%s",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[ \d<> <>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "d ([%a%d]+) / d ([%a%d]+)%s",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[ (\d<>)/(\d<>)<> ]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			i(0),
		}),
		{ condition = math }
	),
	s(
		{
			trig = "f ([%a%d%s%+%-%_%^%[%]()%{}%\\]+)/([%a%d%s%+%-%_%^%[%]()%{}%\\]+);",
			regTrig = true,
			name = "auto subscript",
			dscr = "hi",
			snippetType = "autosnippet",
		},
		fmta([[ (<>)/(<>)<>]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			i(0),
		}),
		{ condition = math }
	),
}
