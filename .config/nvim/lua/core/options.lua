local options = {
    number = true,             -- numberline
    numberwidth = 2,           -- number column width (default: 4)
    relativenumber = true,     -- relative number line
    cursorline = true,         -- cursor line
    title = true,              -- enable window title
    showmode = false,          -- no builtin mode display
    pumheight = 10,            -- limit pum height
    mouse = "a",               -- allow mouse interaction in all modes
    clipboard = "unnamedplus", -- access the system clipboard
    history = 100,             -- number of commands to remember in history
    termguicolors = true,      -- enable 24-bit colors in TUI
    splitright = true,         -- vsplit to right
    list = true,               -- whitespace highlighting
    fileencoding = "utf-8",    -- default file encoding
    ignorecase = true,         -- case insensitive search
    smartcase = true,          -- case insensitive search
    showtabline = 2,           -- always show tabs
    wrap = false,              -- don't wrap long lines
    scrolloff = 8,             -- min. lines kept above and below of the cursor
    sidescrolloff = 8,         -- min. lines kept left and right of the cursor
    timeoutlen = 400,          -- wait time for a mapped sequence to complete
    updatetime = 300,          -- faster completion (4000ms default)
    swapfile = false,          -- creates a swapfile
    undofile = true,           -- enable persistent undo
    writebackup = false,       -- disable making a backup before overwriting
    fillchars = { eob = " " }, -- disable `~` on nonexistent lines

    -- Intentation
    expandtab = true,          -- tabs to spaces
    tabstop = 4,               -- number of spaces per tab
    shiftwidth = 4,            -- number of spaces per indentation
    softtabstop = -1,          -- if negative, shiftwidth value is used
    copyindent = true,         -- copy the previous indentation on autoindenting
    smartindent = true,        -- make indentation smarter
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Other settings --------------------------------------------------------------

vim.opt.completeopt = { "menuone", "noselect" } -- for insert mode completion
vim.wo.colorcolumn = "80"

-- Highlight characters passing the 80 column limit in red
-- vim.w.m1 = vim.fn.matchadd("ErrorMsg", "\\%>80v.\\+", -1)
