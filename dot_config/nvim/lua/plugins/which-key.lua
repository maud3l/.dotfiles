return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	opts = {
		plugins = {
			spelling = true,
			marks = true,
		},
		preset = {
			operators = true, -- adds help for operators like d, y, ...
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			z = true,
			g = true,
		},
		defaults = {
			preset = "helix",
			mode = { "n", "v" },
			{ "g", group = "+goto" },
			{ "]", group = "+next" },
			{ "[", group = "+prev" },
			{ "<leader>a", group = "[A]I" },
			{ "<leader>b", group = "[B]uffers" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>f", group = "[F]ile/find" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>p", group = "[P]ackages" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]erminal" },
			{ "<leader>x", group = "Diagnostics/Quickfi[X]" },
			{ "<leader>w", group = "[W]indows" },
			{ "<leader>q", group = "[Q]uit" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add(opts.defaults)
	end,
}
