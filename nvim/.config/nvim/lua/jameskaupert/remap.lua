vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("v", "<leader>p", [["_dP]])
vim.keymap.set("v", "<leader>y", [["+y]])

