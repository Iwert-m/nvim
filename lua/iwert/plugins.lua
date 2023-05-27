local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- General Nvim plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use({
		"nvim-lua/plenary.nvim",
		tag = "v0.1.3",
	}) -- Useful lua functions used ny lots of plugins
	use({
		"goolord/alpha-nvim",
		tag = "1838ae926e8d49fe5330d1498ee8289ae2c340bc",
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
	})
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		tag = "2.63",
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			"muniftanjim/nui.nvim",
		},
	})
	use({
		"nvim-lualine/lualine.nvim",
		commit = "8912bea65de93a56b1f70cdb7c3c26f9cce30394",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "v2.6.0",
	})
	use({
		"ahmedkhalf/project.nvim",
		commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
	})
	use({
		"rcarriga/nvim-notify",
		tag = "v3.11.0",
	})
	use({
		"olimorris/persisted.nvim",
		commit = "c58219567d9b0ad3c1f1e30a76df996e54ccab60",
	})

	-- Editor plugins
	use({
		"folke/which-key.nvim",
		tag = "v1.4.3",
	})
	use({
		"numToStr/Comment.nvim",
		tag = "v0.8.0",
	})
	use({
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "0bf8fbc2ca8f8cdb6efbd0a9e32740d7a991e4c3",
	})
	use({
		"windwp/nvim-autopairs",
		commit = "59df87a84c80a357ca8d8fe86e451b93ac476ccc",
	})
	use({
		"windwp/nvim-ts-autotag",
		commit = "40615e96075c743ef47aaf9de966dc348bec6459",
	})
	use({
		"lewis6991/gitsigns.nvim",
		tag = "release",
	})
	use({
		"folke/trouble.nvim",
		tag = "v2.3.0",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "v3.5.0",
		requires = "nvim-tree/nvim-web-devicons",
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		tag = "v2.20.6",
	})
	use({
		"famiu/bufdelete.nvim",
		commit = "8933abc09df6c381d47dc271b1ee5d266541448e",
	})
	use({
		"kevinhwang91/nvim-ufo",
		tag = "v1.3.0",
		requires = "kevinhwang91/promise-async",
	})

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim") -- Bridge to hook into NVIM LSP client

	-- NVIM Debugger Adapter Protocol
	use("mfussenegger/nvim-dap")
	use("jayp0521/mason-nvim-dap.nvim")
	use("rcarriga/nvim-dap-ui")
	use("theHamsta/nvim-dap-virtual-text")
	use("nvim-telescope/telescope-dap.nvim")
	use("leoluz/nvim-dap-go")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	use("nvim-treesitter/nvim-treesitter-context")

	-- Colorshemes
	use("rebelot/kanagawa.nvim")
	use("Mofiqul/dracula.nvim")
	use({
		"ellisonleao/gruvbox.nvim",
		tag = "1.0.0",
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
