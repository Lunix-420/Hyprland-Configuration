return { -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },

    {
      "nvim-treesitter/nvim-treesitter-context",
      enabled = true,
      opts = { mode = "cursor", max_lines = 3 },
    },
  },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "hyprlang",
      "rasi",
      "dockerfile",
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-space>",
        node_incremental = "<M-space>",
        scope_incremental = false,
        node_decremental = "<M-bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        kahead = true,
        selection_modes = {
          ["@parameter.outer"] = "v", -- charwise
          ["@function.outer"] = "V", -- linewise
          ["@class.outer"] = "<c-v>", -- blockwise
        },
        keymaps = {

          ["aa"] = { query = "@parameter.outer", desc = "🌲select around function" },
          ["ia"] = { query = "@parameter.inner", desc = "🌲select inside function" },

          ["af"] = { query = "@function.outer", desc = "🌲select around function" },
          ["if"] = { query = "@function.inner", desc = "🌲select inside function" },
          ["ac"] = { query = "@class.outer", desc = "🌲select around class" },
          ["ic"] = { query = "@class.inner", desc = "🌲select inside class" },
          ["al"] = { query = "@loop.outer", desc = "🌲select around loop" },
          ["il"] = { query = "@loop.inner", desc = "🌲select inside loop" },
          ["ab"] = { query = "@block.outer", desc = "🌲select around block" },
          ["ib"] = { query = "@block.inner", desc = "🌲select inside block" },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {},
        goto_previous_start = {},
      },
      lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {},
      },
    },
  },
  config = function(_, opts)
    vim.filetype.add({
      extension = { rasi = "rasi" },
      pattern = {
        [".*/waybar/config"] = "jsonc",
        [".*/mako/config"] = "dosini",
        [".*/kitty/*.conf"] = "bash",
        [".*/hypr/.*%.conf"] = "hyprlang",
      },
    })

    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
  end,
}
