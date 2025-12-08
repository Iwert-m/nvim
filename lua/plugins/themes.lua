return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "dracula/vim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
