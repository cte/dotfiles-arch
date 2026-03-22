return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = {
        dark = "mocha",
        light = "latte",
      },
      term_colors = true,
      transparent_background = false,
      default_integrations = false,
      auto_integrations = false,
      integrations = {
        blink_cmp = { style = "bordered" },
        gitsigns = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        treesitter = true,
      },
      custom_highlights = function(colors)
        return {
          CursorLine = { bg = colors.mantle },
          FloatBorder = { fg = colors.surface2, bg = colors.mantle },
          FloatTitle = { fg = colors.lavender, bg = colors.mantle, style = { "bold" } },
          NormalFloat = { bg = colors.mantle },
          Pmenu = { bg = colors.mantle },
          PmenuSel = { bg = colors.surface0, style = { "bold" } },
          Visual = { bg = colors.surface0 },
          WinSeparator = { fg = colors.surface1 },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
