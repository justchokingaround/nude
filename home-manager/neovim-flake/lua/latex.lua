vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'

vim.g.vimtex_imaps_leader = ';'
vim.g.vimtex_mappings_disable = { ['n'] = { 'K' } } -- disable `K` as it conflicts with LSP hover

vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_quickfix_method = vim.fn.executable('pplatex') == 1 and 'pplatex' or 'latexlog'
vim.g.vimtex_fold_enabled = 1
vim.g.vimtex_matchparen_enabled = 0

vim.g.vimtex_syntax_conceal_disable = 1 -- disable conceal completely
vim.g.vimtex_toc_config = {
    layer_status = { ['content'] = 1, ['label'] = 0, ['todo'] = 1, ['include'] = 0 },
    show_help = 0,
    todo_sorted = 0,
}

vim.g.vimtex_quickfix_ignore_filters = { [[but the package provides `simpler-wick']] }
