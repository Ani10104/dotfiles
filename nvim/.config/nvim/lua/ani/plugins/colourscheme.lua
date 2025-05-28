local function color_scheme(name)
  return require("ani.colorschemes." .. name)
end
return {
  color_scheme(AniVim.colorscheme), -- Add more themes here if needed
}
