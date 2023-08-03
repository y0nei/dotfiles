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
    { -- Status bar for buffers and tabs
        "akinsho/bufferline.nvim", version="*",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                show_buffer_close_icons = false,
                offsets = {
                    { filetype = "NvimTree" }
                }
            }
        },
        config = function(_, opts)
            require("bufferline").setup(opts)
        end
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
    },
    { -- Gitsigns
        "lewis6991/gitsigns.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {
            signs = {
                add          = { text = "▎" },
                change       = { text = "▎" },
                delete       = { text = "" },
                topdelete    = { text = "" },
                changedelete = { text = "~" },
                untracked    = { text = "┆", hl = "LineNr" }
            }
        },
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end
    },
    { -- File browser
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return require("plugins.nvim-tree")
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end
    },
    { -- Better commenting
        "numToStr/Comment.nvim",
        event = { "BufRead", "BufNewFile" },
        opts = {}
    }
})
