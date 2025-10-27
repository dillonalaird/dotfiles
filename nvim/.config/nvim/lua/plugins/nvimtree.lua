return {
	"nvim-tree/nvim-tree.lua",
	config = function()
		require("nvim-tree").setup({})
		local api = require("nvim-tree.api")
		local function opts(desc)
			return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
		end
		vim.keymap.set("n", "<C-h>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		vim.keymap.set("n", "<leader>nt", api.tree.toggle, opts("Toggle"))
		-- vim.keymap.set("n", "<leader>nt", ":NvimTreeToggle<CR>")
		vim.cmd([[
        :hi NvimTreeNormal guibg=NONE
        :hi NvimTreeNormalNC guibg=NONE
        :hi NvimTreeEndOfBuffer guibg=NONE
      ]])
	end,
}
