local builtin = require("telescope.builtin")
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Map leader as space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal mode -----------------------------------------------------------------

-- New buffer
keymap("n", "<leader>bn", "<cmd> enew<CR>", opts)

-- Toggle nvim tree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Delete/kill current buffer
keymap("n", "<leader>bk", "<cmd> BufDel<CR>", opts)
-- Close current buffer
keymap("n", "<leader>wc", "<cmd> clo<CR>", opts)

-- Navigate buffers
keymap("n", "<leader>b]", ":bnext<CR>", opts)
keymap("n", "<leader>b[", ":bprevious<CR>", opts)

-- Split navigation
keymap("n", "<leader>wh", "<C-w>h", opts)
keymap("n", "<leader>wl", "<C-w>l", opts)
keymap("n", "<leader>wj", "<C-w>j", opts)
keymap("n", "<leader>wk", "<C-w>k", opts)

-- Clear highlights
keymap("n", "<Esc>", ":noh<CR>", opts)

-- Telescope functions
keymap("n", "<leader>ff", builtin.find_files, opts)
keymap("n", "<leader>fg", builtin.live_grep, opts)
keymap("n", "<leader>ss", builtin.spell_suggest, opts)

-- Gitsigns
keymap("n", "<leader>gh]", ":Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>gh[", ":Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>ghp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>ghb", ":Gitsigns blame_line<CR>", opts)
keymap("n", "<leader>ghu", ":Gitsigns undo_stage_hunk<CR>", opts)
keymap({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", opts)
keymap({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", opts)
keymap("n", "<leader>ghS", ":Gitsigns stage_buffer<CR>", opts)
keymap("n", "<leader>ghR", ":Gitsigns reset_buffer<CR>", opts)
keymap({ "o", "x" }, "<leader>gh", ":<C-u>Gitsigns select_hunk<CR>", opts)

-- Vim illuminate
-- TODO: Figure out why does this not work when LSP provides highlights
keymap("n", "<leader>]]", function()
    require("illuminate").goto_next_reference(false)
end, { unpack(opts), desc = "Next word reference" })
keymap("n", "<leader>[[", function()
    require("illuminate").goto_prev_reference(false)
end, { unpack(opts), desc = "Previous word reference" })

-- Todo comments
keymap("n", "<leader>t]", function() require("todo-comments").jump_next() end, opts)
keymap("n", "<leader>t[", function() require("todo-comments").jump_prev() end, opts)
keymap("n", "<leader>ft", ":TodoTelescope<cr>", opts)

-- LSP Related
keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
keymap("n", "<leader>d]", vim.diagnostic.goto_next, opts)
keymap("n", "<leader>d[", vim.diagnostic.goto_prev, opts)
keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)

-- Visual mode -----------------------------------------------------------------

-- Don't copy replaced text
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
keymap("x", "p", "p:let @+=@0<CR>:let @\"=@0<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
