-- ============================================================================
-- 📐 Snacks Picker Layouts
-- Pure layout definitions, no logic
-- ============================================================================

local M = {}

----------------------------------------------------------------------------
-- Default picker layout
----------------------------------------------------------------------------
M.custom1 = {
	layout = {
		box = "vertical",
		backdrop = false,
		row = -1,
		width = 0,
		height = 0.4,
		border = "none",
		title = " {title} {live} {flags}",
		title_pos = "left",
		{
			box = "horizontal",
			{ win = "list", border = "rounded" },
			{
				win = "preview",
				rtitle = "{preview}",
				width = 0.4,
				border = "rounded",
			},
		},
		{ win = "input", height = 1, border = "rounded" },
	},
}

----------------------------------------------------------------------------
-- Compact centered picker (code / narrow lists)
----------------------------------------------------------------------------
M.bettercode = {
	layout = {
		backdrop = false,
		width = 0.5,
		min_width = 80,
		max_width = 100,
		height = 0.4,
		min_height = 2,
		box = "vertical",
		border = true,
		title = "{title}",
		title_pos = "center",
		{ win = "input", height = 1, border = "rounded" },
		{ win = "list", border = "none" },
	},
}

----------------------------------------------------------------------------
-- Selection-style picker (buffers, quick lists)
----------------------------------------------------------------------------
M.select2 = {
	layout = {
		backdrop = false,
		width = 0.5,
		min_width = 80,
		max_width = 100,
		height = 0.2,
		min_height = 2,
		box = "vertical",
		border = true,
		title = "{title}",
		title_pos = "center",
		{ win = "list", border = "none" },
		{ win = "input", height = 1, border = "top" },
	},
}

----------------------------------------------------------------------------
-- Sidebar-style picker (right side)
----------------------------------------------------------------------------
M.sidebar2 = {
	layout = {
		backdrop = false,
		width = 40,
		min_width = 40,
		height = 0,
		position = "right",
		border = "none",
		box = "vertical",
		{
			win = "input",
			height = 1,
			border = true,
			title = "{title} {live} {flags}",
			title_pos = "center",
		},
		{ win = "list", border = "rounded" },
		{
			win = "preview",
			title = "{preview}",
			height = 0.1,
			border = "top",
		},
	},
}

----------------------------------------------------------------------------
-- Explorer-style layout (left, no preview)
----------------------------------------------------------------------------
M.explorertheme = {
	preview = "none",
	layout = {
		backdrop = false,
		width = 25,
		min_width = 20,
		height = 0,
		position = "left",
		border = "none",
		box = "vertical",
		{
			win = "input",
			height = 1,
			border = true,
			title = "{title} {live} {flags}",
			title_pos = "center",
		},
		{ win = "list", border = "none" },
	},
}

----------------------------------------------------------------------------
-- Vertical custom layout
----------------------------------------------------------------------------
M.vertical2 = {
	layout = {
		backdrop = false,
		width = 0.5,
		preview = "none",
		min_width = 80,
		height = 0.8,
		min_height = 30,
		box = "vertical",
		border = true,
		title = "{title} {live} {flags}",
		title_pos = "center",
		{ win = "input", height = 1, border = "bottom" },
		{ win = "list", border = "none" },
		-- { win = "preview", title = "{preview}", height = 0.8, border = "top" },
	},
}

return M
