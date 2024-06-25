return {
  "nvim-treesitter/nvim-treesitter",
  vim.filetype.add({
    extension = { rasi = "rasi" },
    pattern = {
      [".*/waybar/config"] = "jsonc",
      [".*/mako/config"] = "dosini",
      [".*/kitty/*.conf"] = "bash",
      [".*/hypr/.*%.conf"] = "hyprlang",
    },
  }),
}
