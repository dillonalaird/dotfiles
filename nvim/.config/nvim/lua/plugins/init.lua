return {
	require("plugins.treesitter"),
	require("plugins.playground"),
	require("plugins.lualine"),
	require("plugins.telescope"),
	require("plugins.cmp"),
	require("plugins.lsp"),
	require("plugins.claudecode"),
  require("plugins.conform"),
  require("plugins.markdown"),
	-- require("plugins.nvimtree"),
	-- require("plugins.nvchad"),
	-- require("plugins.avante"),

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
		"filipdutescu/renamer.nvim",
		config = function()
			require("renamer").setup({})
			vim.keymap.set("n", "<leader>rn", "<cmd>lua require('renamer').rename()<CR>")
		end,
	},
  -- for some reason the cmd to change the backgroudn color does not work when I pull it from require
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({})
			local api = require("nvim-tree.api")
			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end
			vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts("Open: Horizontal Split"))
      vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<leader>nt", api.tree.toggle, opts("Toggle"))
			-- vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
			vim.cmd([[
          :hi NvimTreeNormal guibg=NONE
          :hi NvimTreeNormalNC guibg=NONE
          :hi NvimTreeEndOfBuffer guibg=NONE
        ]])
		end,
	},

	-- {
	--   "sainhe/everforest",
	--   config = function()
	--     lazy = false
	--     vim.g.everforest_background = "medium"
	--     vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]])
	--     vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guibg=NONE]])
	--     vim.cmd.colorscheme("everforest")
	--   end,
	-- },
	--{
	--  "nvim-neo-tree/neo-tree.nvim",
	--  branch = "v3.x",
	--  dependencies = {
	--    "nvim-lua/plenary.nvim",
	--    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	--    "MunifTanjim/nui.nvim",
	--    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
	--  },
	--  lazy = false, -- neo-tree will lazily load itself
	--  ---@module "neo-tree"
	--  ---@type neotree.Config?
	--  opts = {
	--    -- fill any relevant options here
	--  },
	--  config = function(_, opts)
	--    require("neo-tree").setup(opts)
	--    vim.keymap.set("n", "<leader>nt", ":Neotree toggle<CR>")
	--  end,
	--},

	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
}
