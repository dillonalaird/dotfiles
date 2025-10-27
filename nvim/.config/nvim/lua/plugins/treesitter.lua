return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	dependencies = {
		"sainnhe/gruvbox-material",

		-- "sainnhe/everforest",
		-- "ellisonleao/gruvbox.nvim",
		-- "folke/tokyonight.nvim",
		-- "rebelot/kanagawa.nvim",

		lazy = false,
		config = function()
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_transparent_background = 1
			-- makes the diagnostic popup transparent
			-- this needs to be set before setting the colorscheme
			vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]])
			vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guibg=NONE]])
			vim.cmd([[colorscheme gruvbox-material]])
		end,

		-- lazy = false,
		-- config = function()
		-- vim.g.everforest_background = "medium"
		-- 	vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]])
		-- 	vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guibg=NONE]])
		-- 	vim.cmd([[colorscheme everforest]])
		-- end,
	},

	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "python", "lua", "javascript", "typescript", "tsx", "vim", "markdown" },
			sync_install = true,
			highlight = { enable = true },
			-- autotag = { enable = true }, -- this is for nvim-ts-autotag
			indent = { enable = true }, -- not working on svelte for some reason
		})
	end,
}
