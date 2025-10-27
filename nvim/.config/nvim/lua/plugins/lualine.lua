return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },

	config = function()
		local custom_gruvbox = require("lualine.themes.gruvbox-material")

		custom_gruvbox.normal.a.bg = "#7daea3"
		custom_gruvbox.command.a.bg = "#d3869b"

		require("lualine").setup({
			options = {
				-- theme = "gruvbox-material",
				theme = custom_gruvbox,
				-- theme = "everforest",

				-- theme = "tokyonight",
				-- theme = "kanagawa",
				component_separators = { left = "|", right = "" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = "",
					},
				},
				lualine_b = {
					{
						"branch",
						icon = "",
					},
				},
				lualine_c = {
					{
						"filename",
						file_status = true,
						path = 1,
					},
				},
				lualine_x = {
					{ "lsp_status" },
					{ "diagnostics" },
					{ "filetype" },
				},
				lualine_y = { "progress" },
				lualine_z = {
					{
						"location",
						icon = "",
					},
				},
			},
		})
	end,
}
