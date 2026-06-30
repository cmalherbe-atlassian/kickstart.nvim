vim.pack.add {
  'https://github.com/esmuellert/codediff.nvim',
}

require('codediff').setup {
  diff = {
    layout = 'side-by-side',
  },
}

vim.keymap.set('n', '<leader>gd', '<cmd>CodeDiff master...<CR>', { desc = '[G]it [D]iff against master with local changes' })
