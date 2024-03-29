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
		D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
		s = { "<Cmd>:split<Cr>", "New horizontal window split" },
		v = { "<Cmd>:vsplit<Cr>", "New vertical window split" },
		t = { "<Cmd>:tabnew %<Cr>", "New Tab" },
	},

	c = { "<Cmd>Bdelete<Cr>", "Close current buffer" },

	d = {
		name = "Debugger",
		b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Run debug session" },
		s = { "<cmd>lua require'dap'.step_over()<cr>", "Step over" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step into" },
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
		n = { "<cmd>Telescope notify<cr>", "Recent notifications" },
		p = { "<cmd>Telescope persisted<cr>", "Recent sessions" },
		s = { "<cmd>Telescope live_grep<cr>", "Search string" },
	},

	G = { "<cmd>lua _LAZYGIT_TOGGLE()<cr>", "Git" },

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
			k = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover over symbol" },
			r = { "<cmd>Telescope lsp_references<CR>", "Find references" },
			s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Show method signture" },
			n = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename under cursor" },
		},
	}
	whichkey.register(bmappings, bopts)
end

buffer_function()
vim.api.nvim_create_autocmd("BufAdd", {
	callback = function()
		if vim.bo.filetype ~= "neo-tree" then
			vim.schedule(buffer_function)
		end
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

local vmappings = {}
whichkey.register(vmappings, vopts)
