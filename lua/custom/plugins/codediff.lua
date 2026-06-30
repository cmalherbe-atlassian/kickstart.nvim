vim.pack.add {
  'https://github.com/esmuellert/codediff.nvim',
}

require('codediff').setup {
  diff = {
    layout = 'side-by-side',
  },
}

vim.keymap.set('n', '<leader>gd', function()
  local builtin = require 'telescope.builtin'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  builtin.git_branches {
    attach_mappings = function(prompt_bufnr, map)
      local open_codediff = function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not entry then return end

        local branch = entry.value or entry.display or entry.ordinal
        if type(branch) ~= 'string' or branch == '' then return end

        branch = branch:gsub('^%s+', ''):gsub('%s+$', '')
        vim.cmd('CodeDiff ' .. vim.fn.fnameescape(branch) .. '...HEAD')
      end

      map('i', '<CR>', open_codediff)
      map('n', '<CR>', open_codediff)

      return true
    end,
  }
end, { desc = '[G]it [D]iff branch with CodeDiff' })
