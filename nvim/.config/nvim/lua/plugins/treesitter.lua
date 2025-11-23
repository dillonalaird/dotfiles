return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",

	dependencies = {
		"sainnhe/gruvbox-material",

		-- lazy = false,
		-- config = function()
		-- 	vim.g.gruvbox_material_background = "medium"
		-- 	vim.g.gruvbox_material_transparent_background = 1
		-- 	-- makes the diagnostic popup transparent
		-- 	-- this needs to be set before setting the colorscheme
		-- 	vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=NONE]])
		-- 	vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guibg=NONE]])
		-- 	vim.cmd([[colorscheme gruvbox-material]])
		-- end,

		lazy = false,
		config = function()
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_transparent_background = 1

			vim.api.nvim_create_augroup("TransparentFloat", { clear = true })
			vim.api.nvim_create_autocmd("ColorScheme", {
				group = "TransparentFloat",
				callback = function()
					-- transparent backgrounds for common float containers
					for _, g in ipairs({ "NormalFloat", "FloatBorder", "FloatTitle" }) do
						vim.api.nvim_set_hl(0, g, { bg = "none" })
					end

					-- keep diagnostic foreground colors by linking float groups
					local severities = { "Error", "Warn", "Info", "Hint" }
					for _, s in ipairs(severities) do
						vim.api.nvim_set_hl(0, "DiagnosticFloating" .. s, { link = "Diagnostic" .. s })
					end
				end,
			})
			vim.cmd([[colorscheme gruvbox-material]])
		end,
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
