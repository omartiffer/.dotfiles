return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dap_widgets = require("dap.ui.widgets")

            vim.keymap.set("n", "<F5>", dap.continue)
            vim.keymap.set("n", "<F10>", dap.step_over)
            vim.keymap.set("n", "<F11>", dap.step_into)
            vim.keymap.set("n", "<F12>", dap.step_out)
            vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<Leader>B", dap.set_breakpoint)
            vim.keymap.set("n", "<Leader>dr", dap.repl.open)
            vim.keymap.set("n", "<Leader>dl", dap.run_last)
            vim.keymap.set({ "n", "v" }, "<Leader>dh", dap_widgets.hover)
            vim.keymap.set({ "n", "v" }, "<Leader>dp", dap_widgets.preview)
            vim.keymap.set("n", "<Leader>df", function()
                dap_widgets.centered_float(dap_widgets.frames)
            end)
            vim.keymap.set("n", "<Leader>ds", function()
                dap_widgets.centered_float(dap_widgets.scopes)
            end)
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "delve", "js" },
                automatic_installation = true,
            })
        end,
    },
    {
        "leoluz/nvim-dap-go",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-go").setup()
        end,
    },
}
