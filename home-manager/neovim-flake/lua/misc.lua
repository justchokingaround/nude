-- disables "how to disable mouse" message
-- in right click popups
vim.cmd.aunmenu [[PopUp.How-to\ disable\ mouse]]

vim.cmd.aunmenu [[PopUp.-1-]]
local opt = vim.opt

local listchars = {
    tab = " ──",
    trail = "·",
    nbsp = "␣",
    precedes = "«",
    extends = "»",
}

local fillchars = {
    eob = " ",
    vert = " ",
    horiz = " ",
    diff = "╱",
    foldclose = "",
    foldopen = "",
    fold = " ",
    msgsep = "─",
}

opt.fillchars = fillchars
opt.listchars = listchars

opt.autowrite = true
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard
-- opt.conceallevel = 0          -- so that `` is visible in markdown files
opt.conceallevel = 2          -- so that `` is visible in markdown files
opt.concealcursor = "nc"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.cursorline = false
opt.diffopt:append("linematch:60")
opt.expandtab = true -- use spaces instead of tabs
-- j: join lines when typing Enter,
-- c: auto-wrap lines when they get too long,
-- r: remove trailing whitespaces when saving,
-- o: smart auto-indenting,
-- l: enable listchars,
-- n: enable comment-related features,
-- t: enable text-width formatting,
-- q: indenting of comments
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.isfname:append(":")
opt.laststatus = 0 -- hide statusline in inactive windows
opt.list = true    -- show invisible characters (tabs...)
opt.listchars = listchars
opt.number = false
opt.pumblend = 0                                                    -- popup menu transparency, this sets it to be black
opt.pumheight = 10                                                  -- limit completion items
opt.relativenumber = false
opt.scrolloff = 4                                                   -- lines of context
opt.shiftround = true
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } -- options saved when you close a session
opt.shiftwidth = 4
opt.shortmess:append({ W = true, I = true, c = true, C = true })    -- messages to be shown when making changes to a file
opt.showbreak = "⤷ "
opt.showmode = false                                                -- don't show mode (insert, replace, etc), since they're already shown in the statusline
opt.sidescrolloff = 8                                               -- columns of context
opt.splitkeep = "screen"                                            -- keep window open when splitting
opt.tabstop = 4
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200
opt.winminwidth = 5 -- minimum width of a window
opt.wrap = false    -- wrap lines by default
opt.writebackup = true
opt.wildmode = { "longest", "list", "full" }
--
-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- for the git diff
vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0A2B2B" })
vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#393939", bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffChange", { bg = "#161616" })
vim.api.nvim_set_hl(0, "DiffText", { bg = "#161616" })


vim.g["test#strategy"] = "vimux"
vim.cmd [[colorscheme gruber-darker]]
