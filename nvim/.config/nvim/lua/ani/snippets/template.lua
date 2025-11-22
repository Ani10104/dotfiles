local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require 'luasnip.util.events'
local ai = require 'luasnip.nodes.absolute_indexer'
local extras = require 'luasnip.extras'
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require 'luasnip.extras.expand_conditions'
local conds_expand = require 'luasnip.extras.conditions.expand'
local postfix = require('luasnip.extras.postfix').postfix
local types = require 'luasnip.util.types'
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key
local snippet = ls.add_snippets

require('luasnip').config.setup { store_selection_keys = '<Tab>' }

ls.setup {
  enable_autosnippets = true,
  update_events = { 'TextChanged', 'TextChangedI' },
}

-- similar to global p! functions from UltiSnips

local function math()
  return vim.api.nvim_eval 'vimtex#syntax#in_mathzone()' == 1
end

local function text()
  return not math()
end

local function env(name)
  local is_inside = vim.fn['vimtex#env#is_inside'](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

--[
-- personal imports
--]
-- local tex = require 'luasnip-latex-snippets.luasnippets.tex.utils.conditions'
-- local make_condition = require('luasnip.extras.conditions').make_condition
-- local in_bullets_cond = make_condition(tex.in_bullets)
local line_begin = require('luasnip.extras.conditions.expand').line_begin

-- -- for TikZ environments. Note that you will need to define new helper functions with this setup
-- local function tikz()
--   return env 'tikzpicture'
-- end

local function enum()
  return env 'enumerate'
end

local function item()
  return env 'itemize'
end

local function list()
  return env 'list'
end

local function parts()
  return env 'parts'
end

local function align_nil()
  return env 'align'
end

local function align_star()
  return env 'align*'
end

snippet('tex', {

  --Templates for various things.

  --Question Template
  s(
    'tempq1',
    fmt(
      [[
      \documentclass[addpoints,12pt, a4paper]{exam}
      \pagestyle {empty}
      \usepackage{amsmath,amssymb,amsfonts,float}
      \usepackage{pgf}
      \usepackage{tfrupee}
      \usepackage{tikz,pgfplots}
      \RequirePackage{geometry}
      \usepackage{datenumber}
      \setdatetoday
      \addtocounter{datenumber}{0}%
      \setdatebynumber{\thedatenumber}%
      \geometry{top = 1.5cm, bottom = 1cm, left = 2cm, right = 1.5cm}
      \usetikzlibrary{positioning}
      \pgfplotsset{compat = 1.18}
      \parindent 0px
      %-----------------------------------------------------------------------------------------------------------
      % \newcommand{\duration}{60 minutes} % default duration
      % custom command to calculate the duration based on total points and drop decimal places
      % custom command to calculate the duration based on total points and truncate decimal places
      \newcommand{\calculateduration}{
          % calculate duration based on points (1 point = 0.6 minutes)
          \pgfmathtruncatemacro{\totalduration}{\numpoints * 1.5}
          % use the truncated result to update the duration
          \newcommand{\duration}{\totalduration\space minutes}
      }
      \newcommand{\examduration}{
        \calculateduration % call the calculation
          \duration % output the calculated duration
      }
      %-----------------------------------------------------------------------------------------------------------
      \pointsinmargin
      \pointformat{}
      \marksnotpoints
      \totalformat{Total: \totalpoints}
      \title{\vspace{-1.5cm}{\huge\textbf{<>}}\\[2mm]
              {\LARGE Mathematics}\\[2mm]
              {Date: {\datedate}}\\[3mm]
              {\large Full Marks:\numpoints \hfill  Class -- VI \hfill Time: \examduration}
              \vspace{3pt}
              \hrule\vspace{-2em}}
      \date{}
      \begin{document}
              \maketitle
              \begin{questions}

                      \question \textbf{Very Short Answer type questions} \hfill \totalpoints
                      <>

                      \question \textbf{Short Answer type questions} \hfill \totalpoints

                      \question \textbf{Medium Answer type questions} \hfill \totalpoints

                      \question \textbf{Long Answer type questions} \hfill \totalpoints

             \end{questions}
              \line(1,0){497}
      \end{document}
      ]],
      {
        f(function()
          local filename = vim.fn.expand '%:t:r'
          return (filename:gsub('_', ' '):gsub('(%a)([%w]*)', function(first, rest)
            return first:upper() .. rest:lower()
          end))
        end),
        i(0),
      },
      { delimiters = '<>' }
    ),
    { condition = text, show_condition = text }
  ),
})
