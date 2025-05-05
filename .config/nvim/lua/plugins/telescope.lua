return {
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--follow", -- Follow symbolic links
                        "--hidden", -- Search for hidden files
                        "--no-heading", -- Don't group matches by each file
                        "--with-filename", -- Print the file path with the matched lines
                        "--line-number", -- Show line numbers
                        "--column", -- Show column numbers
                        "--smart-case", -- Smart case search
                        "--glob=!**/.git/*", -- Exclude .git directories
                        "--glob=!**/.idea/*", -- Exclude .idea directories
                        "--glob=!**/.vscode/*", -- Exclude .vscode directories
                        "--glob=!**/build/*", -- Exclude build directories
                        "--glob=!**/dist/*", -- Exclude dist directories
                        "--glob=!**/yarn.lock", -- Exclude yarn.lock files
                        "--glob=!**/package-lock.json", -- Exclude package-lock.json files
                    },
                    file_ignore_patterns = { -- Additional ignore patterns
                        "node_modules",
                        "build",
                        "dist",
                        "yarn.lock",
                        "package-lock.json",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true, -- Show hidden files
                        find_command = { -- Command to find files
                            "rg",
                            "--files",
                            "--hidden",
                            "--glob=!**/.git/*",
                            "--glob=!**/.idea/*",
                            "--glob=!**/.vscode/*",
                            "--glob=!**/build/*",
                            "--glob=!**/dist/*",
                            "--glob=!**/yarn.lock",
                            "--glob=!**/package-lock.json",
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matchingdw
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
        end,
    },
}
