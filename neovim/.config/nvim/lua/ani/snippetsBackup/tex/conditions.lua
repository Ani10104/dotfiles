--[
-- LuaSnip Conditions
--]

local M = {}

-- math / not math zones
function M.in_math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

-- comment detection
function M.in_comment()
    return vim.fn["vimtex#syntax#in_comment"]() == 1
end

-- document class
function M.in_beamer()
    return vim.b.vimtex["documentclass"] == "beamer"
end

-- generic env checker
local function env(name)
    local is_inside = vim.fn["vimtex#env#is_inside"](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_preamble()
    return not env("document")
end

function M.in_text()
    return env("document") and not M.in_math()
end

function M.in_tikz()
    return env("tikzpicture")
end

function M.in_bullets()
    return env("itemize") or env("enumerate")
end

function M.in_align()
    return env("align") or env("align*") or env("aligned")
end

-- line-begin check for autosnippets
function M.show_line_begin(line_to_cursor)
    return #line_to_cursor <= 3
end

-- cursor not inside (), {}, or []
function M.not_in_brackets()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()

    -- text before cursor
    local before = line:sub(1, col)

    -- count opening/closing brackets before cursor
    local o_paren = select(2, before:gsub("%(", ""))
    local c_paren = select(2, before:gsub("%)", ""))

    local o_brace = select(2, before:gsub("{", ""))
    local c_brace = select(2, before:gsub("}", ""))

    local o_bracket = select(2, before:gsub("%[", ""))
    local c_bracket = select(2, before:gsub("%]", ""))

    -- If there are more opens than closes, cursor is inside bracket
    if o_paren > c_paren then return false end
    if o_brace > c_brace then return false end
    if o_bracket > c_bracket then return false end

    return true
end
return M
