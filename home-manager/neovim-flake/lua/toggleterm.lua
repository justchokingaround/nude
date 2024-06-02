local toggleterm = require('toggleterm')

toggleterm.setup({
  size = 20,
  highlights = {
    Normal = { guibg = "#161616" },
    NormalFloat = { link = "Normal" },
    FloatBorder = { guifg = "#ee5396", guibg = "#161616" },
  },
  hide_numbers = true,
  start_in_insert = true,
  direction = "float",
  close_on_exit = true,
  float_opts = { border = "curved" },
})
