local M = {}

local function configure_exts()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    vim.notify("Could not load DAP")
    return
  end
  require('telescope').load_extension('dap')
  require("nvim-dap-virtual-text").setup {
    commented = true,
  }
  local dapui = require "dapui"
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

local function configure_debuggers()
  require("iwert.dap.go")
end

function M.setup()
  configure_exts()
  configure_debuggers()
end

return M
