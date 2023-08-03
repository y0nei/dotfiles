local ok, lazy = pcall(require, "lazy")
if not ok then
    require("core.bootstrap")
    lazy = require("lazy")
end

lazy.setup({
    { -- Command "autocompletion" popup
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
        end,
        opts = { --[[ TODO ]] }
    },
    { -- Onedark colorscheme
        "navarasu/onedark.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("onedark").setup { style = "warm" }
            require("onedark").load()
            -- Change cursor line number color
            vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#F0C674" })
        end
    },
    { -- Status bar with Onedark theme
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = true,
                theme = "onedark",
                section_separators = "",
            }
        }
    },
    { -- Telescope file search
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons"
        }
    },
    { -- Improved syntax highlighting
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile", "InsertEnter" },
        -- Additional cmd's to lazy-load the plugin with if no events trigger
        cmd = { "TSInstall", "TSBufEnable" },
        build = ":TSUpdate",
        opts = function()
            return require("plugins.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
     }
})
