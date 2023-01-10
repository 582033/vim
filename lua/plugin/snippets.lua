-- 映射快捷键
vim.cmd[[imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']]
vim.cmd[[imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']]
vim.cmd[[smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>']]
vim.cmd[[smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>']]

-- help vsnip查看配置说明
--配置一处来源
vim.g.vsnip_snippet_dir = '~/.config/nvim/habit/vsnip/'
--vim.cmd[[let g:vsnip_snippet_dir = '~/.config/nvim/habit/snippets']]
