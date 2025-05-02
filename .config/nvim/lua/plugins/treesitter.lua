return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "bash",
                "javascript",
                "typescript",
                "html",
                "css",
                "astro",
                "go",
                "python",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,
            indent = {
                enable = true,
                disable = { "bash" },
            },

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "gnn", -- set to `false` to disable one of the mappings
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
        })
    end,
}
