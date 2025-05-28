
; Match \textbf{...}
(generic_command
  name: (command_name) @_cmd
  (group
    (brace_group
      (text) @textbf.inner))
  (#eq? @_cmd "textbf"))
