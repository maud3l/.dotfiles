-- Previews

vim.keymap.set(
	"n",
	"gpd",
	"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
	{ noremap = true, desc = "[G]o to [P]review [D]efinition" }
)
vim.keymap.set(
	"n",
	"gpt",
	"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
	{ noremap = true, desc = "[G]o to [P]review [T]ype Definition" }
)
vim.keymap.set(
	"n",
	"gpi",
	"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
	{ noremap = true, desc = "[G]o to [P]review [I]mplementation" }
)
vim.keymap.set(
	"n",
	"gpD",
	"<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
	{ noremap = true, desc = "[G]o to [P]review [D]eclaration" }
)
vim.keymap.set(
	"n",
	"gP",
	"<cmd>lua require('goto-preview').close_all_win({skip_curr_window = true})<CR>",
	{ noremap = true, desc = "Close All [P]review Windows" }
)
vim.keymap.set(
	"n",
	"gpr",
	"<cmd>lua require('goto-preview').goto_preview_references()<CR>",
	{ noremap = true, desc = "[G]o to [P]review [R]eferences" }
)

return {
	"rmagatti/goto-preview",
	event = "BufEnter",
	config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
}
