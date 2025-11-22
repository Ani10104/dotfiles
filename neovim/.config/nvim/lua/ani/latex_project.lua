local uv = vim.loop

local function create_latex_project(project_name)
	if not project_name or project_name == "" then
		vim.notify("You must provide a project name!", vim.log.levels.ERROR)
		return
	end

	-- Prompt for main file name
	-- Prompt for main file name with a default suggestion
	local default_main = "main"
	local main_file = vim.fn.input("Enter name for main .tex file (default: " .. default_main .. "): ")
	if main_file == "" then
		main_file = default_main  -- use default if empty
	end
	if not main_file:match(".tex$") then
		main_file = main_file .. ".tex"
	end

	local cwd = vim.fn.getcwd()
	local project_dir = cwd .. "/" .. project_name
	local general_dir = project_dir .. "/General"

	-- Create directories (mkdir -p equivalent)
	vim.fn.mkdir(general_dir, "p")

	-- Template dir
	local template_dir = vim.fn.expand("~") .. "/Templates/latex/"

	-- Copy all preamble-*.tex files into General/
	local preamble_files = vim.fn.glob(template_dir .. "preamble-*.tex", 0, 1)
	for _, src in ipairs(preamble_files) do
		local filename = vim.fn.fnamemodify(src, ":t")
		local dst = general_dir .. "/" .. filename
		vim.fn.writefile(vim.fn.readfile(src), dst)
	end

	-- Copy all .tex files into General/
	local tex_files = vim.fn.glob(template_dir .. "*.tex", 0, 1)
	if #tex_files == 0 then
		vim.notify("No .tex files found in " .. template_dir, vim.log.levels.WARN)
	else
		for _, src in ipairs(tex_files) do
			local filename = vim.fn.fnamemodify(src, ":t")
			local dst = general_dir .. "/" .. filename
			vim.fn.writefile(vim.fn.readfile(src), dst)
		end
	end

	-- Copy all .sty files
	local sty_files = vim.fn.glob(template_dir .. "*.sty", 0, 1)
	for _, file in ipairs(sty_files) do
		local filename = vim.fn.fnamemodify(file, ":t")
		vim.fn.writefile(vim.fn.readfile(file), project_dir .. "/" .. filename)
	end

	-- Copy .latexmkrc file if it exists
	local latexmkrc_src = template_dir .. ".latexmkrc"
	local latexmkrc_dst = project_dir .. "/.latexmkrc"
	if vim.fn.filereadable(latexmkrc_src) == 1 then
		vim.fn.writefile(vim.fn.readfile(latexmkrc_src), latexmkrc_dst)
	else
		vim.notify(".latexmkrc not found in " .. template_dir, vim.log.levels.WARN)
	end

	-- Copy copypdf.sh if it exists
	local copypdf_src = template_dir .. "copypdf.sh"
	local copypdf_dst = project_dir .. "/copypdf.sh"
	if vim.fn.filereadable(copypdf_src) == 1 then
		vim.fn.writefile(vim.fn.readfile(copypdf_src), copypdf_dst)
		-- Make the copied file executable (chmod 755)
		uv.fs_chmod(copypdf_dst, 448) -- 448 decimal = 0o700 + 0o50 + 0o5 = 0o755
		vim.notify("Copied and made executable: copypdf.sh")
	else
		vim.notify("copypdf.sh not found in " .. template_dir, vim.log.levels.WARN)
	end

	-- Write main tex file boilerplate
	local main_tex_path = project_dir .. "/" .. main_file
	local tex_content = {
		"\\documentclass[12pt]{article}",
		"",
		"\\begin{document}",
		"",
		"% Your content here",
		"",
		"\\end{document}",
	}
	vim.fn.writefile(tex_content, main_tex_path)

	-- Open the created file in buffer
	vim.cmd("edit " .. main_tex_path)
	vim.notify("✅ Created LaTeX project: " .. project_name .. " with main file: " .. main_file)
end

return {
	create_latex_project = create_latex_project,
}
