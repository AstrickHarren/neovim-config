local opts = {
  component_aliases = {
    -- Most tasks are initialized with the default components
    default = {
      { "display_duration", detail_level = 2 },
      "on_output_summarize",
      "on_exit_set_status",
      "on_complete_notify",
      "on_complete_dispose",
      "on_result_diagnostics",
      { "on_output_parse", parser = { "extract_efm" } },
      { "on_output_quickfix", items_only = true, open_on_exit = "failure" },
    },
  },
}

require("overseer").setup(opts)
require("overseer").add_template_hook({ module = "cargo" }, function(task_defn, util)
  util.add_component(task_defn, {
    "on_output_quickfix",
    open_on_exit = "failure",
    items_only = true,
    errorformat = [[%-Gnote: run with `RUST_BACKTRACE=%.%#,]]
      .. [[%Eerror: %\%%(aborting %\|could not compile%\)%\@!%m,]]
      .. [[%Eerror[E%n]: %m,]]
      .. [[%Nnote: %m,]]
      .. [[%Wwarning: %\%%(%.%# warning%\)%\@!%m,]]
      .. [[%C %#--> %f:%l:%c,]]
      .. [[%E  left:%m,%C right:%m %f:%l:%c,%Z,]]
      .. [[%E%>%.%#panicked at %f:%l:%c:,]]
      .. [[%Z%m,]],
  })
end)
