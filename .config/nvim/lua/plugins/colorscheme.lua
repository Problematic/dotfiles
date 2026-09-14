-- Matches the Catppuccin Mocha palette shared by alacritty, tmux, bat, btop,
-- delta, fzf, starship and yazi.
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = { dark = "mocha", light = "latte" },
      -- alacritty already runs at 0.97 opacity; a transparent bg on top of
      -- that washes out the text, so keep nvim's own background opaque.
      transparent_background = false,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        neogit = true,
        noice = true,
        snacks = true,
        rainbow_delimiters = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin-mocha" } },
}
