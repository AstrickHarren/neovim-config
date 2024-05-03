local opts = {
  progress = {
    lsp = {
      progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
      log_handler = false, -- Log `$/progress` handler invocations (for debugging)
    },
  },
}

require("fidget").setup(opts)
