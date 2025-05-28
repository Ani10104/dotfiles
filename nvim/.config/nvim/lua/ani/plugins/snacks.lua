local icons = require('lib.icons')
return {
	'folke/snacks.nvim',
	priority = 1000,
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true,  notify = true},
		image = {enabled = true,
			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},
			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
			-- window options applied to windows displaying image buffers
			-- an image buffer is a buffer with `filetype=image`
			wo = {
				wrap = false,
				number = false,
				relativenumber = false,
				cursorcolumn = false,
				signcolumn = "no",
				foldcolumn = "0",
				list = false,
				spell = false,
				statuscolumn = "",
			},
			cache = vim.fn.stdpath("cache") .. "/snacks/image",
			debug = {
				request = false,
				convert = false,
				placement = false,
			},
			env = {},
			-- icons used to show where an inline image is located that is
			-- rendered below the text.
			icons = {
				math = "󰪚 ",
				chart = "󰄧 ",
				image = " ",
			},
			math = {
				enabled = true, -- enable math expression rendering
				-- in the templates below, `${header}` comes from any section in your document,
				-- between a start/end header comment. Comment syntax is language-specific.
				-- * start comment: `// snacks: header start`
				-- * end comment:   `// snacks: header end`
				typst = {
					tpl = [[
	#set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
	#show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
	#set text(size: 12pt, fill: rgb("${color}"))
	${header}
	${content}]],
				},
				latex = {
					font_size = "Large", -- see https://www.sascha-frank.com/latex-font-size.html
					-- for latex documents, the doc packages are included automatically,
					-- but you can add more packages here. Useful for markdown documents.
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
					tpl = [[
	\documentclass[preview,border=0pt,varwidth,12pt]{standalone}
	\usepackage{${packages}}
	\begin{document}
	${header}
	{ \${font_size} \selectfont
	  \color[HTML]{${color}}
	${content}}
	\end{document}]],
				},
			},
			-- your image configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		dashboard = {
			enabled = true,
			preset = {
				pick = function(cmd, opts)
					return Snacks.picker.pick(cmd, opts)
				end,

				header = [[
                                                                      
        ████ ██████           █████      ██                     
       ███████████             █████                             
       █████████ ███████████████████ ███   ███████████   
      █████████  ███    █████████████ █████ ██████████████   
     █████████ ██████████ █████████ █████ █████ ████ █████   
   ███████████ ███    ███ █████████ █████ █████ ████ █████  
  ██████  █████████████████████ ████ █████ █████ ████ ██████ 
				  ]],
				-- stylua: ignore
				---@type snacks.dashboard.Item[]
				keys = {
					{ icon = icons.ui.Search, key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon =icons.documents.Explorer, key = "e", desc = "Explorer", action = "<cmd>lua MiniFiles.open()<CR>" },
					{ icon =icons.documents.NewFile, key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon =icons.ui.Search_Text, key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = icons.documents.Recent_Files, key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = icons.ui.Config, key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
					{ icon =icons.ui.Restore, key = "s", desc = "Restore Session", action = "<cmd>SessionManager load_session<CR>" },
					{ icon = icons.ui.Sleep, key = "l", desc = "Lazy", action = ":Lazy" },
					{ icon =icons.type.Boolean, key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		buffdelete = {enabled = true},
		indent = { enabled = true },
		input = { enabled = true, icon = icons.ui.Edit,
			icon_hl = 'SnacksInputIcon',
			icon_pos = 'left',
			prompt_pos = 'title',
			win = { style = 'input' },
			expand = true, },
		picker = {
			enabled = true,
			hidden = true, -- Show hidden files by default
			ignored = true, -- Show ignored files by default
			sources = {
				files = {
					hidden = true,
					follow_file = true,
					-- Additional configurations as needed
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		zen = {
			enabled = true,
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				-- diagnostics = false,
				-- inlay_hints = false,
			},
			show = {
				statusline = false,
				tabline = false,
			},
			win = { style = 'zen' },
			zoom = {
				toggles = {},
				show = { statusline = true, tabline = true },
				win = {
					backdrop = false,
					width = 0,
				},
			},
		},

		latex = {
			patterns = {
				{
					match = [[\\textbf{([^}]*)}]],
					group = 1,
					style = "bold",
				},
				{
					match = [[\\textit{([^}]*)}]],
					group = 1,
					style = "italic",
				},
				{
					match = [[\\emph{([^}]*)}]],
					group = 1,
					style = "italic",
				},
			},
		},
	},
	keys = {
		-- Top Pickers & Explorer
		{
			'<leader><space>',
			function()
				Snacks.picker.smart()
			end,
			desc = 'Smart Find Files',
		},
		{
			'<leader>un',
			function()
				Snacks.notifier.hide()
			end,
			desc = 'Dismiss All Notifications',
		},
		-- {
		--   '<c-/>',
		--   function()
		--     Snacks.terminal()
		--   end,
		--   desc = 'Toggle Terminal',
		-- },
	},
}
