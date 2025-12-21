return {
	"nvim-mini/mini.statusline",
	event = "BufReadPre", -- safe lazy-load trigger
	config = function()
		require("mini.statusline").setup({
			-- Content of statusline as functions which return statusline string. See
			-- `:h statusline` and code of default contents (used instead of `nil`).
			content = {
				-- Content for active window
				active = function()
					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local git = MiniStatusline.section_git({ trunc_width = 40 })
					local diff = MiniStatusline.section_diff({ trunc_width = 75 })
					local diagnostics = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						signs = {
							ERROR = " ",
							WARN = " ",
							INFO = " ",
							HINT = "󰌵 ",
						},
					})
					local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
					local filename = MiniStatusline.section_filename({ trunc_width = 140 })
					-- ✅ CUSTOM fileinfo → "lua [unix]"
					local function short_fileinfo_with_icon()
						local ft = vim.bo.filetype
						local ff = vim.bo.fileformat

						if ft == "" then
							return ""
						end

						local icon = ""
						local ok, devicons = pcall(require, "nvim-web-devicons")
						if ok then
							local icon_char = devicons.get_icon_by_filetype(ft)
							if icon_char then
								icon = icon_char .. " "
							end
						end

						return string.format("%s%s [%s]", icon, ft, ff)
					end

					local fileinfo = short_fileinfo_with_icon()
					local location = MiniStatusline.section_location({ trunc_width = 75 })
					local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

					return MiniStatusline.combine_groups({
						{ hl = mode_hl,                 strings = { mode } },
						{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
						"%<", -- Mark general truncate point
						{ hl = "MiniStatuslineFilename", strings = { filename } },
						"%=", -- End left alignment
						{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
						{ hl = mode_hl,                  strings = { search, location } },
					})
				end,
				-- Content for inactive window(s)
				inactive = nil,
			},

			-- Whether to use icons by default
			use_icons = true,
		})
	end
}
