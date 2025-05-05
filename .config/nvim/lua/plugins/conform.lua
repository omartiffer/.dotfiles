return {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
        local conform = require("conform")
        local prettier_filetypes = {
            "Angular",
            "CSS",
            "Flow",
            "GraphQL",
            "HTML",
            "JSON",
            "JSX",
            "JavaScript",
            "LESS",
            "Markdown",
            "SCSS",
            "TypeScript",
            "Vue",
            "YAML",
        }

        local prettier_formatters = {}
        for _, ft in ipairs(prettier_filetypes) do
            prettier_formatters[ft] = { "prettierd", "prettier", stop_after_first = true }
        end

        conform.setup({
            formatters_by_ft = {
                lua = {
                    "stylua",
                    lsp_format = "never",
                },
                python = { "isort", "black" },
                sh = { "shfmt", "shellharden" },
                prettier_formatters,
                --["*"] = { "codespell" },
                --["_"] = { "trim_whitespace" },
            },
            formatters = {
                stylua = {
                    prepend_args = {
                        "--indent-type",
                        "Spaces",
                        "--indent-width",
                        "4",
                    },
                },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end,
    default_format_opts = {
        lsp_format = "fallback",
    },
    notify_on_error = true,
    notify_no_formatters = true,
}
