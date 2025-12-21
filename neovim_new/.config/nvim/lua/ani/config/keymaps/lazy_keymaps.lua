-- lua/ani/keymaps/lazy_keymaps.lua

local spec = require("ani.config.keymaps.spec")

local M = {}

function M.for_plugin(plugin_name)
	local keys = {}

	for _, section in ipairs(spec) do
		local prefix = section.prefix or ""

		for _, m in ipairs(section.maps or {}) do
			if m.load == "plugin" and m.plugin == plugin_name then
				local lhs = prefix .. m.key

				table.insert(keys, {
					lhs, -- ✅ full key: <leader>ff, <leader>z, etc.
					m.action,
					mode = m.mode,
					desc = m.desc,
				})
			end
		end
	end

	return keys
end

return M
