
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Disable esc for Insert -> Normal
vim.keymap.set('i', '<Esc>', '<Nop>')

-- Insert -> Normal
vim.keymap.set('i', 'jj', '<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "use actual key that works genius"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Removing all ^M instances from file

vim.keymap.set('n', '<leader>cr', ':%s/\\r//g<CR>')
