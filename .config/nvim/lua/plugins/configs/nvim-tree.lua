require("nvim-web-devicons").setup({
    strict = true,
    override_by_extension = {
        astro = {
            icon = "",
            color = "#EF8547",
            name = "astro",
        },
        lockb = {
            icon = "󰈡",
            color = "#fbf0df",
            name = "lockb"
        }
    },
    override_by_filename = {
        ["astro.config.mjs"] = {
            icon = "",
            color = "#EF8547",
            name = "astro-config"
        }
    }
})

return {
    update_focused_file = {
        enable = true
    },
    renderer = {
        highlight_opened_files = "name",
        indent_markers = {
            enable = true
        },
        icons = {
            glyphs = {
                git = {
                    unstaged = "",
                    staged = "S",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "U",
                    deleted = "",
                    ignored = "◌",
                }
            }
        }
    },
    git = { ignore = false }
}
