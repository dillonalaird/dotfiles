return {
	require("plugins.treesitter"),
	require("plugins.playground"),
	require("plugins.lualine"),
	require("plugins.cmp"),
	require("plugins.lsp"),
	require("plugins.claudecode"),
  require("plugins.conform"),
  require("plugins.markdown"),
  require("plugins.snacks"),

	"nvim-treesitter/nvim-treesitter-context",
	"tpope/vim-commentary",
	"tpope/vim-fugitive",
	"github/copilot.vim",
	"chrisbra/csv.vim",
	"chrisbra/Colorizer",
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
}
