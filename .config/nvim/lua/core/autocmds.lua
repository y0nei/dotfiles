vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Disable automatic comment insertion",
    group = vim.api.nvim_create_augroup("AutoComment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Briefly highlight yanked lines",
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank()
    end
})
