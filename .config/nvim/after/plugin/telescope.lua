local builtin = require('telescope.builtin')
-- require('telescope').load_extension('fzf')


vim.keymap.set('n', '<leader>pf', builtin.find_files, {}) -- pf: project files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {}) -- pb: project buffers
vim.keymap.set('n', '<leader>pg', builtin.live_grep, {}) -- pg: project (live) grep

