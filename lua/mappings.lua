require "nvchad.mappings"

local U = require "utils"
local find = U.find
local vim_cmd = U.vim_cmd
local M = {}
local map = vim.keymap.set

M.Telescope = {
  n = {
    ["<C-f>"] = { find("telescope.builtin"):of("find_files"):ap(), "find files" },
    ["<C-g>"] = { find("telescope.builtin"):of("live_grep"):ap(), "live grep" },
    ["<leader>fc"] = { find("telescope.builtin"):of("highlights"):ap(), "find highlights" },
    ["<leader>fj"] = { find("telescope.builtin"):of("jumplist"):ap(), "search jumplist" },
    ["<leader>fs"] = { find("telescope.builtin"):of("lsp_dynamic_workspace_symbols"):ap(), "go to workspace symbols" },
    ["<leader>fo"] = { find("telescope.builtin"):of("lsp_document_symbols"):ap(), "go to document symbols" },
  },
}

M.LSP = {
  n = {
    ["gd"] = { find("telescope.builtin"):of("lsp_definitions"):ap(), "go to defs" },
    ["gr"] = { find("telescope.builtin"):of("lsp_references"):ap(), "go to refs" },
    ["gt"] = { find("telescope.builtin"):of("lsp_type_definitions"):ap(), "go to type defs" },
    ["gm"] = { find("telescope.builtin"):of("lsp_implementations"):ap(), "go to impls" },
    ["Y"] = { U.vim:of("diagnostic"):of("open_float"):apc { border = "rounded" }, "Floating diagnostic" },
    ["<leader>ll"] = { vim_cmd "LspInfo", "lsp info" },
    ["<leader>ra"] = { U.vim:of("lsp"):of("buf"):of("rename"):ap(), "rename" },
    ["R"] = { U.vim:of("lsp"):of("buf"):of("rename"):ap(), "rename" },
  },
  i = {
    ["<C-,>"] = { U.vim:of("lsp"):of("buf"):of("signature_help"):ap(), "Signature help" },
  },
  [{ "n", "i" }] = {
    ["<C-.>"] = { U.vim:of("lsp"):of("buf"):of("code_action"):ap(), "Code action" },
  },
}

M.Terminal = {
  t = {
    ["<C-U>"] = { "<C-\\><C-n><C-U>", "go up half page" },
  },
  n = {
    ["<Esc>"] = { vim_cmd("q"):only_if(U.vim:of("api"):of("nvim_get_mode"):ap():of("mode"):eq "nt"), "close terminal" },
  },
}

M.Git = {
  n = {
    ["<leader>gd"] = { find("diffview"):seq(vim_cmd "DiffviewOpen"), "open diffview" },
    ["<leader>gh"] = { find("diffview"):seq(vim_cmd "DiffviewFileHistory %"), "open file history" },
    ["<leader>gg"] = { find("neogit"):of("open"):ap(), "open neogit" },
    ["<leader>gc"] = { find("neogit"):of("action"):apc("commit", "commit", {}):ap(), "git commit" },
    ["<leader>gs"] = { find("gitsigns"):of("stage_hunk"):ap(), "stage hunk" },
    ["<leader>gu"] = { find("gitsigns"):of("undo_stage_hunk"):ap(), "undo stage hunk" },
    ["<leader>gr"] = { find("gitsigns"):of("reset_hunk"):ap(), "reset hunk" },
    ["<leader>gp"] = { find("gitsigns"):of("preview_hunk"):ap(), "preview hunk" },
    ["<leader>gb"] = { find("gitsigns"):of("blame_line"):ap(), "blame line" },
  },
}

M.Lazy = {
  n = {
    ["<leader>L"] = { vim_cmd "Lazy", "open lazy" },
  },
}

M.Editor = {
  n = {
    ["<C-S-/>"] = { vim_cmd "NvCheatsheet", "nvchad cheatsheet" },
    ["<C-q>"] = { vim_cmd "qa", "quit neovim" },
    ["<C-w>"] = { find("nvchad.tabufline"):of("close_buffer"):ap(), "close buffer" },
    ["<M-S-w>"] = { vim_cmd "%bd|e#", "close all other buffers" },
    ["<C-S-w>"] = { vim_cmd "q", "close window" },
    ["<leader>w"] = { "<c-w>", "window cmd" },
    ["<C-s>"] = {
      find("conform"):of("format"):apc({ lsp_fallback = true }):seq(vim_cmd "w"):only_if(U.filetype:ne "NvimTree"),
      "format and save",
    },

    ["U"] = { "<c-r>", "redo" },
  },
}

M.Comment = {
  n = {
    ["<C-/>"] = { find("Comment.api"):of("toggle"):of("linewise"):of("current"):ap(), "toggle comment" },
  },
  v = {
    ["<C-/>"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "Toggle comment",
    },
  },
}

M.Quickfix = {
  [{ "n", "v" }] = {
    ["<M-f>"] = { U.lift(U.toggle_qf), "toggle quick fix" },
    ["<leader>qf"] = { vim_cmd "cw", "open quick fix" },
    ["<leader>qj"] = { vim_cmd "cnext", "next quick fix" },
    ["<leader>qk"] = { vim_cmd "cprev", "prev quick fix" },
  },
}

M.Task = {
  n = {
    ["<C-r>"] = { find("overseer"):seq(vim_cmd "OverseerRun"), "run task" },
    ["<M-r>"] = { find("overseer"):seq(vim_cmd "OverseerQuickAction open float"), "open float of last run" },
    ["<C-S-r>"] = { find("overseer"):of("toggle"):ap(), "open float of last run" },
  },
}

local function load_mappings(mappings)
  for mod, mapping in pairs(mappings) do
    for mode, m in pairs(mapping) do
      for lhs, value in pairs(m) do
        local rhs = type(value[1]) == "string" and value[1] or value[1].eval
        local desc = value[2]
        map(mode, lhs, rhs, { desc = mod .. " " .. desc })
      end
    end
  end
end
load_mappings(M)
