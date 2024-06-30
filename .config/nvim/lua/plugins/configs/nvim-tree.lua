require("nvim-web-devicons").setup({
    strict = true,
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
