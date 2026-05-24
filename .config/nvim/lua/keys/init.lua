vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

--[[ disable esc for insert -> normal ]]
vim.keymap.set('i', '<Esc>', '<Nop>')

--[[ insert -> normal ]]
vim.keymap.set('i', 'jj', '<Esc>')

--[[ clear highlights on search when pressing <esc> in normal mode (see :help hlsearch) ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

--[[ diagnostic keymaps ]]
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

--[[ disable arrow keys in normal mode ]]
vim.keymap.set('n', '<left>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "use actual key that works genius"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "use actual key that works genius"<CR>')

--[[ split navigation (use ctrl + hjkl, see :help wincmd) ]]
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--[[ remove carriage return (^m) characters ]]
vim.keymap.set('n', '<leader>cr', ':%s/\\r//g<CR>')

