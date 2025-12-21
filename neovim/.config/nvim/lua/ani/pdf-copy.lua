local M = {}

local EXPORT_DIR = vim.fn.expand("~/Documents/LaTeX-Exports")

local function get_project_root()
	-- directory of current buffer
	local buf = vim.api.nvim_get_current_buf()
	local file = vim.api.nvim_buf_get_name(buf)

	if file == "" then
		return nil
	end

	return vim.fn.fnamemodify(file, ":p:h")
end

function M.latex_export_pdf()
	local project_root = get_project_root()

	if not project_root then
		vim.notify("❌ No active file to determine project root", vim.log.levels.ERROR)
		return
	end

	local SOURCE_DIR = project_root .. "/Output"

	if vim.fn.isdirectory(SOURCE_DIR) == 0 then
		vim.notify("❌ Output directory not found in project", vim.log.levels.ERROR)
		return
	end

	vim.ui.input({ prompt = "Export PDF as: " }, function(name)
		if not name or name == "" then
			return
		end

		vim.fn.mkdir(EXPORT_DIR, "p")

		local pdfs = vim.fn.globpath(SOURCE_DIR, "*.pdf", false, true)

		if #pdfs == 0 then
			vim.notify("❌ No PDFs found", vim.log.levels.ERROR)
			return
		end

		table.sort(pdfs, function(a, b)
			return vim.fn.getftime(a) > vim.fn.getftime(b)
		end)

		local src = pdfs[1]
		local dst = EXPORT_DIR .. "/" .. name .. ".pdf"

		vim.fn.writefile(vim.fn.readfile(src, "b"), dst, "b")

		vim.fn.delete(src)

		vim.notify("✅ Exported PDF to " .. dst, vim.log.levels.INFO)
	end)
end

return M
