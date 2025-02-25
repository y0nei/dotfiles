local ok, lazy = pcall(require, "lazy")
if not ok then
    require("plugins.bootstrap")
    lazy = require("lazy")
end

lazy.setup({
    { -- Better buffer deletion
        "ojroques/nvim-bufdel",
        cmd = { "BufDel", "BufDelAll", "BufDelOthers" }
    },
    { -- Command "autocompletion" popup
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
        end,
        opts = {}
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
                disabled_filetypes = { "NvimTree" }
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
        }
    },
    { -- Telescope file search
        "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "folke/todo-comments.nvim"
        }
    },
    { -- Improved syntax highlighting
        "nvim-treesitter/nvim-treesitter",
        event = { "BufRead", "BufNewFile", "InsertEnter" },
        -- Additional cmd's to lazy-load the plugin with if no events trigger
        cmd = { "TSInstall", "TSBufEnable" },
        build = ":TSUpdate",
        dependencies = {
            -- Rainbow parentheses (UNMAINTAINED SINCE 2023)
            "p00f/nvim-ts-rainbow",
            "RRethy/vim-illuminate",
            "lukas-reineke/indent-blankline.nvim"
        },
        opts = function()
            return require("plugins.configs.treesitter")
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },
    { -- Indentation guides
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufRead", "BufNewFile" },
        opts = {
            indent = { char = "▏" },
            scope = { enabled = false }
        }
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
        }
    },
    { -- File browser
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            return require("plugins.configs.nvim-tree")
        end,
        config = function(_, opts)
            require("nvim-tree").setup(opts)
        end
    },
    { -- Better commenting
        "numToStr/Comment.nvim",
        keys = {
            { "gcc", mode = "n", desc = "Comment toggle current line" },
            { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
            { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
            { "gbc", mode = "n", desc = "Comment toggle current block" },
            { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
            { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" }
        },
        opts = {}
    },
    { -- Auto close bracket pairs
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },
    { -- Auto close & rename tags
        "windwp/nvim-ts-autotag",
        dependencies = "nvim-treesitter/nvim-treesitter",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    { -- Highlight colors
        "NvChad/nvim-colorizer.lua",
        event = { "BufRead", "BufNewFile" },
        opts = function()
            return require("plugins.configs.nvim-colorizer")
        end,
        config = function(_, opts)
            require("colorizer").setup(opts)
        end
    },
    { -- Highlight instances of the same word
        "RRethy/vim-illuminate",
        event = { "BufRead", "BufNewFile" },
        opts = {
            delay = 200,
            large_file_cutoff = 2000,
            large_file_overrides = {
                providers = { "lsp" }
            }
        },
        config = function(_, opts)
            require("illuminate").configure(opts)
        end
    },
    { -- Find a list of 'TODO', 'BUG', 'NOTE', etc. comments and list them
        "folke/todo-comments.nvim",
        cmd = { "TodoTelescope" },
        event = { "BufRead", "BufNewFile" },
        opts = function()
            return require("plugins.configs.todo-comments")
        end,
        config = function(_, opts)
            require("todo-comments").setup(opts)
        end
    },
    { -- Hyprlang language grammar
        "tree-sitter-grammars/tree-sitter-hyprlang",
        dependencies = { "nvim-treesitter" },
        event = "BufRead */hypr/*.conf",
        build = ":TSUpdate hyprlang",
        config = function()
            vim.filetype.add({
                pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
            })
            require("nvim-treesitter.parsers").get_parser_configs().hyprlang = {
                install_info = {
                    url = "https://github.com/tree-sitter-grammars/tree-sitter-hyprlang",
                    files = { "src/parser.c" },
                    branch = "master",
                },
                filetype = "hyprlang",
            }
        end
    },

    -- LSP
    {
        "williamboman/mason.nvim",
        cmd = {
            "Mason", "MasonInstall", "MasonInstallAll",
            "MasonUninstall", "MasonUninstallAll", "MasonLog"
        },
        build = ":MasonUpdate",
        opts = {
            ensure_installed = { "lua-language-server", "stylua" }
        }
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("plugins.configs.lspconfig")
        end
    },
    {
        "creativenull/efmls-configs-nvim",
        version = "v1.x.x",
        dependencies = { "neovim/nvim-lspconfig" }
    },

    -- Completions
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            { -- Snuppet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = {
                    history = true,
                    updateevents = "TextChanged,TextChangedI"
                },
                config = function(_, opts)
                    require("plugins.configs.luasnip").setup(opts)
                end
            },
            { -- Auto close bracket pairs
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_pairs = require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on(
                        "confirm_done",
                        cmp_pairs.on_confirm_done()
                    )
                end
            },
            { -- CMP sources
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path"
            }
        },
        opts = function()
            return require("plugins.configs.cmp")
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end
    }
})
