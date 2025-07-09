local map = vim.keymap.set

-- Map git stuff
map('n', '<leader>grl', ':Gitsigns reset_hunk<CR>', {noremap = true, silent = true, desc = 'Undo line with Git'})
map('n', '<leader>gp', ':Gitsigns preview_hunk<CR>', {noremap = true, silent = true, desc = 'Git preview'})
