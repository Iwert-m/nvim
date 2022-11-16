local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
  vim.notify("Could not load which-key")
  return
end

local conf = {
  presets = {
    g = false,
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

-- Global mappings for normal mode
local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
  ["w"] = { "<cmd>update!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },

  b = {
    name = "Buffer",
    c = { "<Cmd>bd!<Cr>", "Close current buffer" },
    D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
  },

  e = {
    name = "Explorer",
    b = { "<cmd>Neotree buffers<cr>", "Buffers" },
    f = { "<cmd>Neotree<cr>", "Files" },
  },

  f = {
    name = "Finder",
    f = { "<cmd>Telescope find_files<cr>", "Find files" },
    g = { "<cmd>Telescope grep_string<cr>", "Search selected word" },
    s = { "<cmd>Telescope live_grep<cr>", "Search string" },
  },

  t = {
    name = "Diagnostics",
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document diagnostics" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace diagnostics" },
  },

  z = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
}
whichkey.register(mappings, opts)

-- Buffer local mappings for local mode
local function buffer_function()
  local bopts = {
    mode = "n", -- Normal mode
    prefix = "<leader>",
    buffer = 0, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local bmappings = {
    l = {
      name = "LSP",
      D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Find declaration" },
      d = { "<cmd>Telescope lsp_definitions<CR>", "Find definition" },
      i = { "<cmd>Telescope lsp_implementations", "Find implementation" },
      l = { '<cmd>lua vim.diagnostic.open_float(0,{scope="line", border="rounded"})<CR>', "Line diagnostic" },
      r = { "<cmd>Telescope lsp_references<CR>", "Find references" },
    },
  }
  whichkey.register(bmappings, bopts)
end

buffer_function()
vim.api.nvim_create_autocmd("BufAdd", {
  callback = function()
    vim.schedule(buffer_function)
  end,
})

-- Global mappings for visual mode
local vopts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local vmappings = {
}
whichkey.register(vmappings, vopts)
