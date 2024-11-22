-- Neotest is a Neovim plugin for running tests
-- https://github.com/nvim-neotest/neotest

---@type LazyPluginSpec
return {
	"rcarriga/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",

		-- Adapters
		"nvim-neotest/neotest-go",
	},
	opts = function()
		return {
			adapters = {
				require("neotest-go")({
					recursive_run = true,
				}),
			},
			consumers = {
				overseer = require("neotest.consumers.overseer"),
			},
		}
	end,
	keys = {
		{
			"<leader>ctr",
			function()
				require("neotest").run.run()
			end,
			desc = "[T]est [R]un",
		},
		{
			"<leader>ctf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "[T]est [F]ile",
		},
		{
			"<leader>cta",
			function()
				require("neotest").run.run(vim.fn.getcwd())
			end,
			desc = "[T]est [A]ll",
		},

		{
			"<leader>cts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "[T]est [S]ummary",
		},
		{
			"<leader>cto",
			function()
				require("neotest").output_panel.toggle()
			end,
			desc = "[T]est [O]utput panel",
		},
	},
}
