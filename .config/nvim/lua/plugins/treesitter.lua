local options = {
    ensure_installed = { "lua", "vim" },
    highlight = { enable = true },
    indent = { enable = true },
    rainbow = {
        enable = true,
        disable = { "html", "css" },
        extended_mode = false
    }
}

return options
