return {
	"linrongbin16/gitlinker.nvim",
	cmd = "GitLink",
	opts = {},
	keys = {
		{ "<leader>glc", "<cmd>GitLink<cr>",  mode = { "n", "v" }, desc = "Copy [G]it [L]ink [C]urrent" },
		{
			"<leader>gld",
			"<cmd>GitLink default_branch<cr>",
			mode = { "n", "v" },
			desc = "Copy [G]it [L]ink for [D]efault Branch",
		},

		{ "<leader>gol", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "[G]it [O]pen [L]ink" },
	},
}
