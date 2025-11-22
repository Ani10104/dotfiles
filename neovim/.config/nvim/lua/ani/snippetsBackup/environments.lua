---@diagnostic disable: undefined-global
require("ani.snippets.tex.preamble")
--[
-- personal imports
--]
snippet('tex', {
	autosnippet(
		'pac',
		fmta(
			[[
\usepackage{<>}
<>
    ]],
			{
				i(1, 'Packages'),
				i(0),

			},
			{ condition = when_in.preamble })
	),

	autosnippet(
		'Pac',
		fmta(
			[[
\usepackage[<>]{<>}
<>
    ]],
			{
				i(1, 'Options'),
				i(2, 'Packages'),
				i(0),
			},
			{condition = when_in.preamble})
	),
})

