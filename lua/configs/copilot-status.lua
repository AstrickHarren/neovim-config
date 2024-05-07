require("copilot_status").setup {
  icons = {
    idle = "%#St_White#" .. "",
    error = "%#St_lspError#" .. "",
    offline = "%#St_White#" .. "",
    warning = "%#St_lspWarning#" .. "",
    loading = "%#St_White#" .. "",
  },
  debug = false,
}
