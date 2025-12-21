-- 4. load the rest of your config (keymaps, options, etc.)
require("ani.config")
-- 2. load AniVim (store it!)
require("AniVim")

-- 1. plugins first
require("ani.lazy")

require("ani.config.theme").apply()
