return {
    search = {
        args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            -- Additional globs to exclude
            "--glob=!node_modules", -- JS
            "--glob=!bundle.js", -- JS
            "--glob=!site-packages" -- Python
        }
    }
}
