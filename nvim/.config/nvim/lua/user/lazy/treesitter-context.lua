return {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = {
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
        local ts_ctx = require("treesitter-context")
        ts_ctx.setup({
        })
    end
}
