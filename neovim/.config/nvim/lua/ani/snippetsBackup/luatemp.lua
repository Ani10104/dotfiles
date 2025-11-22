---@diagnostic disable: undefined-global
require("ani.snippets.tex.preamble")

--[
-- personal imports
--]

snippet('lua', {
	autosnippet(
		'main_snip',
		{
			t({ "snippet('", }), i(1), t({ "', {", "" }),

			t({ "    s(", "" }),

			t({ "        '", }), i(2), t({ "',", "" }),

			t({ "        fmt(", "" }),

			-- [[...]] block
			t({ "            [[", "    " }), i(3), t({ "", "    ]],", "" }),

			-- args block
			t({ "            {", "                " }), i(4), t({ "", "            },", "" }),

			t({ "            { delimiters = '<>'"}), i(5) , t({" }, )", "    ),", "})" }), i(0)
		},
		{
			condition = conds.line_begin * when_in.no_brackets,
			show_aondition = conds.line_begin,
			description = "Template to create new LuaSnip snippet definitions"
		}

	),
	autosnippet(
		';ss',
		{
			t({ "s( '"}), i(1), t({ "',", "" }),

			t({ "        fmta(", "" }),

			-- [[...]] block
			t({ "            [[", "    " }), i(2), t({ "", "    ]],", "" }),

			-- args block
			t({ "            {", "                " }), i(3), t({ "", "            },", "" }),

			t({ "            {"}), i(4) , t({"})", "    ),"}), i(0)
		},
		{
			condition = conds.line_begin * when_in.no_brackets,
			show_aondition = conds.line_begin,
			description = "Expand Normal Snippet Template"
		}

	),
	autosnippet(
		';as',
		{
			t({ "autosnippet( '"}), i(1), t({ "',", "" }),

			t({ "        fmta(", "" }),

			-- [[...]] block
			t({ "            [[", "    " }), i(2), t({ "", "    ]],", "" }),

			-- args block
			t({ "            {", "                " }), i(3), t({ "", "            },", "" }),

			t({ "            {"}), i(4) , t({"})", "    ),"}), i(0)
		},
		{
			condition = conds.line_begin * when_in.no_brackets,
			show_aondition = conds.line_begin,
			description = "Expand Auto Snippet Template"
		}

	),
})

