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
			z = true,
			g = true,
		},
		defaults = {
			preset = "helix",
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader>a"] = { name = "[A]I" },
			["<leader>b"] = { name = "[B]uffers" },
			["<leader>c"] = { name = "[C]ode" },
			["<leader>d"] = { name = "[D]ebug" },
			["<leader>f"] = { name = "[F]ile/find" },
			["<leader>g"] = { name = "[G]it" },
			["<leader>p"] = { name = "[P]ackages" },
			["<leader>s"] = { name = "[S]earch" },
			["<leader>x"] = { name = "[D]iagnostics/Quickfix" },
			["<leader>w"] = { name = "[W]indows" },
			["<leader>z"] = { name = "[Q]uit" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}
