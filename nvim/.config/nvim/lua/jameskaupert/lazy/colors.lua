local catppuccin_macchiato = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('catppuccin-macchiato')
    end
}

local gruvbox_material = {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme('gruvbox-material')
    end
}

local nord = {
    'shaunsingh/nord.nvim',
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('nord')
    end
}

local nordic = {
    'AlexvZyl/nordic.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme('nordic')
    end
}

local edge = {
    'sainnhe/edge',
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.edge_enable_italic = true
        vim.cmd.colorscheme('edge')
    end
}

local rosepine = {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
        local rp = require('rose-pine')
        rp.setup({
            variant = "moon",
            dark_variant = "moon"
        })
        vim.cmd.colorscheme('rose-pine')
    end
}

local onedarkpro = {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
        vim.cmd.colorscheme('onedark')
    end
}

-- error colors aren't set --
local kanagawa_paper = {
    "sho-87/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        vim.cmd.colorscheme('kanagawa-paper')
    end
}

local everforest = {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.everforest_enable_italic = true
        vim.cmd.colorscheme('everforest')
    end
}

return everforest
