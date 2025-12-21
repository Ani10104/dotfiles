local spec = require("ani.config.keymaps.spec")

for _, section in ipairs(spec) do
	local prefix = section.prefix or ""

	for _, m in ipairs(section.maps or {}) do
		local load = m.load
		if load ~= "plugin" then
			local lhs = prefix .. m.key

			vim.keymap.set(m.mode, lhs, m.action, { desc = m.desc, silent = true })
		end
	end
end
