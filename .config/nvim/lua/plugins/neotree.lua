return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		{ "3rd/image.nvim", opts = {} },
		{
			"s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
			version = "2.*",
			config = function()
				require("window-picker").setup({
					popup_border_style = "rounded",
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
				})
			end,
		},
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			enable_cursor_hijack = true,
			use_popups_for_input = true,
			window = {
				width = 40,
				mappings = {
					["P"] = {
						"toggle_preview",
						config = {
							use_float = true,
						},
					},
				},
			},
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
				},
			},
		})
		vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
		vim.keymap.set("i", "<C-w>e", "<Cmd>Neotree toggle<CR>")
	end,
}
