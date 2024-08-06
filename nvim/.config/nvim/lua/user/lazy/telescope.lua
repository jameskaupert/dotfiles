return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.8',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    config = function()
        require('telescope').setup({})

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", function()
            builtin.find_files({})
        end, { desc = "Find in files"})
        vim.keymap.set("n", "<leader>ph", function()
            builtin.find_files({ hidden=true })
        end, { desc = "Find in files (+hidden)"})
        vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find in git files"})
        vim.keymap.set("n","<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("Grep > "), hidden=true })
        end, { desc = "Grep search (+hidden)"})
    end
}
