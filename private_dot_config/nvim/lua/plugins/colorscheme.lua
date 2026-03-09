return {
  -- 1. BANISH tokyonight back to the shadow realm
  { "folke/tokyonight.nvim", enabled = false },

  -- 2. ADD catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- load this FIRST before other UI plugins
    opts = {
      flavour = "mocha", -- latte | frappe | macchiato | mocha
      transparent_background = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = { enabled = true },
        which_key = true,
        mini = { enabled = true },
        treesitter = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            warnings = { "undercurl" },
          },
        },
      },
    },
  },

  -- 3. TELL LazyVim to actually use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
