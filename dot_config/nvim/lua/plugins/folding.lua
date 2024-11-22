return {
	"kevinhwang91/nvim-ufo",
	event = "BufReadPost",
	dependencies = {
		"kevinhwang91/promise-async",
		"nvim-treesitter/nvim-treesitter",
	},
	init = function()
		vim.o.foldenable = true
		vim.o.foldcolumn = "auto"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
	end,
	opts = {
		provider_selector = function()
			return { "treesitter", "indent" }
		end,
	},
}
