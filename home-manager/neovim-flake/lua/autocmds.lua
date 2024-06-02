-- alias for vim.api.nvim_create_autocmd
local create_autocmd = vim.api.nvim_create_autocmd

-- taken from https://github.com/sitiom/nvim-numbertoggle
-- I would much rather avoid fetching yet another plugin for something
-- that should be done locally - and not as a plugin
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

-- enable spell checking & line wrapping
-- for git commit messages
create_autocmd({ "FileType" }, {
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Highlight yank after yanking
create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})


-- Close terminal window if process exists with code 0
create_autocmd("TermClose", {
  callback = function()
    if not vim.b.no_auto_quit then
      vim.defer_fn(function()
        if vim.api.nvim_get_current_line() == "[Process exited 0]" then
          vim.api.nvim_buf_delete(0, { force = true })
        end
      end, 50)
    end
  end,
})
