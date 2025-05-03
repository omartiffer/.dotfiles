
vim.g.mapleader = " "

vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "[d", function() vim.diagnossic.get_prev() end, { desc = "Prev diagnostic" })
vim.keymap.set("n", "]d", function() vim.diagnostic.get_next() end, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>sd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
vim.keymap.set("n", "<leader>sdl", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

vim.keymap.set("n", "<leader><CR>", ":so ~/.config/nvim/init.lua<CR>")
