--enabled
--vim.g.blamer_enabled = 1
--delay, default 1000
vim.g.blamer_delay = 500
--Prefix, default ' '
vim.g.blamer_prefix = '• '
--default: '<committer>, <committer-time> • <summary>'
--available options: <author>, <author-mail>, <author-time>, <committer>, <committer-mail>, <committer-time>, <summary>, <commit-short>, <commit-long>.
vim.g.blamer_template = '<committer> | <summary> | <committer-time>'
--Date format
vim.g.blamer_date_format = '%Y-%m-%d %H:%M'
--insert mode disable
vim.g.blamer_show_in_insert_modes = 0

--key map
vim.api.nvim_set_keymap('n', '<leader>g', ':BlamerToggle<cr>', {})
