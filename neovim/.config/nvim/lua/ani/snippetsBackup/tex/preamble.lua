-- preamble.lua

-- Load the LuaSnip module
local ls = require 'luasnip'

-- Shorthand aliases for LuaSnip functions and nodes
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

-- Utility modules and functions
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda

-- Formatting functions
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

-- Conditions for expanding snippets
local conds = require 'luasnip.extras.expand_conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'
local line_begin = conds_expand.line_begin

-- Postfix snippets
local postfix = require('luasnip.extras.postfix').postfix

-- Types and parser
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet

-- Multi-snippet and key indexer
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

-- Functions to add and extend snippets
local snippet = ls.add_snippets
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- Custom conditions module
local myconds = require("ani.snippets.tex.conditions")
local make_condition = require("luasnip.extras.conditions").make_condition

-- local in_bullets_cond = make_condition(myconds.in_bullets)
local not_inside_bracket = make_condition(myconds.not_in_brackets)

-- New readable condition namespace
local when_in = {
    math        = make_condition(myconds.in_math),
    text        = make_condition(myconds.in_text),
    bullets     = make_condition(myconds.in_bullets),
    no_brackets = make_condition(myconds.not_in_brackets),
    preamble = make_condition(myconds.in_preamble),
}

-- Configure LuaSnip
require('luasnip').config.setup {
	store_selection_keys = '<Tab>'
}

ls.setup {
	enable_autosnippets = true,
	update_events = { 'TextChanged', 'TextChangedI' },
}

-- EXPORT EVERYTHING TO GLOBAL ENVIRONMENT
local export = {
    ls = ls,
    s = s, sn = sn, isn = isn,
    t = t, i = i, f = f, c = c, d = d, r = r,

    events = events, ai = ai, extras = extras,
    l = l, rep = rep, p = p, m = m, n = n, dl = dl,

    fmt = fmt, fmta = fmta,

    postfix = postfix,
    types = types,
    parse = parse,
    ms = ms, k = k,

    snippet = snippet,
    autosnippet = autosnippet,

    conds = conds,
    line_begin = line_begin,
    in_bullets_cond = in_bullets_cond,
    not_inside_bracket = not_inside_bracket,
    when_in = when_in,
}

for key, value in pairs(export) do
    _G[key] = value
end

return export
