return {
	"chrisgrieser/nvim-spider",
	lazy = true,
	consistentOperatorPending = true,
	keys = {
		{
			"e",
			"<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"b",
			"<cmd>lua require('spider').motion('b')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			"w",
			"<cmd>lua require('spider').motion('w')<CR>",
			mode = { "n", "o", "x" },
		},
		{
			-- vim.keymap.set("n", "cw", "c<cmd>lua require('spider').motion('e')<CR>")
			"cw",
			"c<cmd>lua require('spider').motion('e')<CR>",
			mode = { "n" },
		},
	},
}
