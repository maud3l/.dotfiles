vim.opt.termguicolors = true
require("bufferline").setup {
options = {
-- Use nvim built-in lsp
diagnostics = "nvim_lsp",
-- open a vertical split on right clicking the buffer name
right_mouse_command = "vertical sbuffer %d",
-- Get out of the way on the left nvim-tree The location of
offsets = {{
filetype = "NvimTree",
text = "File Explorer",
highlight = "Directory",
text_align = "left"
}},
}
}
