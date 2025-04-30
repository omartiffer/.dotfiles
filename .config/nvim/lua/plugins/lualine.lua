return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local none_ls_utils = require("config.utils")
		require("lualine").setup({

			options = {
				theme = "auto",
			},
			sections = {
				lualine_c = {
					{ none_ls_utils.active_tools },
				},
			},
		})
	end,
}
