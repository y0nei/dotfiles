local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Map leader as space
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode -----------------------------------------------------------------

-- New buffer
keymap("n", "<leader>b", "<cmd> enew<CR>", opts)

-- Navigate buffers
keymap("n", "<leader><S-l>", ":bnext<CR>", opts)
keymap("n", "<leader><S-h>", ":bprevious<CR>", opts)

-- Split navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- Clear highlights
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Visual mode -----------------------------------------------------------------

-- Don't copy replaced text
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap("x", "p", "p:let @+=@0<CR>:let @\"=@0<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
