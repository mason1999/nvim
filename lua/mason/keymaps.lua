local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
-- otherwise we would always have to type out vim.api.nvim_set_keymap every time we mapped
local keymap = vim.api.nvim_set_keymap

-- Remap , as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- "n" is for normal mode. keymap() is a function defined up above and opts is a variable defined above. 
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- " e" run the command ":Lexplore 30 <cr>". press it again to toggle it. 30 is the size of the left hand explorer. 
--keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows. Positive directions indicate increasing sizes
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Visual --
-- In visual mode, you can then just spam the arrow keys for indentation. kinda useful
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down with visual mode and capital letters. 
keymap("v", "J", ":move '>+1<CR>gv-gv", opts)
keymap("v", "K", ":move '<-2<CR>gv-gv", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts) -- this one is the same as ":Telescope find_files" but there's too much NOISE with the preview
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts) -- this one searches for files without the noise
keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts) -- <ctrl-t> to find phrases

-- NvimTree --
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- for python -- 
vim.api.nvim_command('autocmd Filetype python map ,r :vsplit term://python3 % <cr> i')

-- for R --
vim.api.nvim_command('autocmd Filetype r inoremap <buffer> > <Esc>:normal! a%>%<CR>a')
vim.api.nvim_command('autocmd Filetype r map ,<S-g> mk<S-v><S-g>,ss`k<Esc>')
