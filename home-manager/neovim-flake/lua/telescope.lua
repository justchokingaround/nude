local telescope = require("telescope")

telescope.setup({
  defaults = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    winblend = 0,
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,

    mappings = {
      i = {
        ["<C-j>"] = function(...)
          require("telescope.actions").move_selection_next(...)
        end,
        ["<C-k>"] = function(...)
          require("telescope.actions").move_selection_previous(...)
        end,
      },
    },
  }
})
