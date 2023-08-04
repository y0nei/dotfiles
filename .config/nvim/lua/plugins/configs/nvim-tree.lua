-- Auto-close nvim-tree buffer if it's the last window
-- src: https://github.com/nvim-tree/nvim-tree.lua/wiki/Auto-Close
vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
        local invalid_win = {}
        local wins = vim.api.nvim_list_wins()
        for _, w in ipairs(wins) do
            local buf = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
                if buf:match("NvimTree_") ~= nil then
                table.insert(invalid_win, w)
            end
        end
        if #invalid_win == #wins - 1 then
            -- Should quit, so we close all invalid windows.
            for _, w in ipairs(invalid_win) do
                vim.api.nvim_win_close(w, true)
            end
        end
    end
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
