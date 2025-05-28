
-- Load the LuaSnip module
local ls = require 'luasnip'

-- Shorthand aliases for LuaSnip functions and nodes
local s = ls.snippet                    -- Define a new snippet
local sn = ls.snippet_node              -- Define a snippet node (used for nested snippets)
local isn = ls.indent_snippet_node      -- Define an indented snippet node
local t = ls.text_node                  -- Define a text node (static text)
local i = ls.insert_node                -- Define an insert node (placeholder for user input)
local f = ls.function_node              -- Define a function node (dynamic content based on a function)
local c = ls.choice_node                -- Define a choice node (select between multiple options)
local d = ls.dynamic_node               -- Define a dynamic node (content changes based on other nodes)
local r = ls.restore_node               -- Define a restore node (preserve user input across snippet expansions)

-- Utility modules and functions
local events = require 'luasnip.util.events'             -- Events for triggering snippet actions
local ai = require 'luasnip.nodes.absolute_indexer'      -- Absolute indexer for referencing nodes
local extras = require 'luasnip.extras'                  -- Extra utility functions
local l = extras.lambda                                  -- Lambda function for simple computations
local rep = extras.rep                                   -- Repeat content of a node
local p = extras.partial                                 -- Partial function application
local m = extras.match                                   -- Match function for conditional snippets
local n = extras.nonempty                                -- Check if a node is non-empty
local dl = extras.dynamic_lambda                         -- Dynamic lambda function for dynamic nodes

-- Formatting functions
local fmt = require('luasnip.extras.fmt').fmt            -- Format snippets using placeholders
local fmta = require('luasnip.extras.fmt').fmta          -- Format snippets with angle brackets

-- Conditions for expanding snippets
local conds = require 'luasnip.extras.expand_conditions' -- Conditions for snippet expansion
local conds_expand = require 'luasnip.extras.conditions.expand' -- Additional expansion conditions

-- Postfix snippets
local postfix = require('luasnip.extras.postfix').postfix -- Define postfix snippets

-- Types and parser
local types = require 'luasnip.util.types'               -- Define snippet types
local parse = require('luasnip.util.parser').parse_snippet -- Parse snippets from strings

-- Multi-snippet and key indexer
local ms = ls.multi_snippet                              -- Define multiple snippets
local k = require('luasnip.nodes.key_indexer').new_key   -- Create a new key for restore nodes

-- Functions to add and extend snippets
local snippet = ls.add_snippets                          -- Add snippets to LuaSnip
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" }) -- Define auto-expanding snippets

-- Configure LuaSnip
require('luasnip').config.setup {
  store_selection_keys = '<Tab>'                         -- Key to store visual selection
}

-- Setup LuaSnip with additional options
ls.setup {
  enable_autosnippets = true,                            -- Enable auto-expanding snippets
  update_events = { 'TextChanged', 'TextChangedI' },     -- Events that trigger snippet updates
}
