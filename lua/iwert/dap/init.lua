local status_ok, dap = pcall(require, "dap")
if not status_ok then
	vim.notify("Could not load DAP")
	return
end

local dap_breakpoint = {
	error = {
		text = "",
		texthl = "LspDiagnosticsSignError",
		linehl = "",
		numhl = "",
	},
	rejected = {
		text = "",
		texthl = "LspDiagnosticsSignHint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "",
		texthl = "LspDiagnosticsSignInformation",
		linehl = "DiagnosticUnderlineInfo",
		numhl = "LspDiagnosticsSignInformation",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)

require("mason-nvim-dap").setup({
	automatic_setup = true,
})

require("mason-nvim-dap").setup_handlers({
	function(source_name)
		require("mason-nvim-dap.automatic_setup")(source_name)
	end,
	delve = function()
		require("dap-go").setup()
	end,
})

require("telescope").load_extension("dap")
require("nvim-dap-virtual-text").setup({
	commented = true,
})
local dapui = require("dapui")
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
