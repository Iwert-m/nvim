return {
  "folke/which-key.nvim",
  optional = true,
  opts = {
    defaults = {
      -- DAP
      ["<leader>d"] = { name = "+debug" },
      ["<leader>da"] = { name = "+adapters" },
      -- NeoTest
      ["<leader>t"] = { name = "+test" },
    },
  },
}
