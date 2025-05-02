return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                --transparent_background = true,
                termcolors = true,
            })
            --vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        "Mofiqul/dracula.nvim",
        name = "dracula",
        config = function()
            require("dracula").setup({
                transparent_bg = true,
            })
            vim.cmd.colorscheme("dracula")
        end,
    },
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                --transparent = true,
                styles = {
                    functions = {},
                },
                on_colors = function(colors)
                    colors.hint = colors.orange
                    colors.error = "#ff0000"
                end,
            })
            --vim.cmd.colorscheme("tokyonight")
        end,
    },
}
