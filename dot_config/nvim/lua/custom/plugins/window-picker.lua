return {
	"s1n7ax/nvim-window-picker",
	name = "window-picker",
	event = "VeryLazy",
	version = "2.*",
	config = function()
		require("window-picker").setup()
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ww",
			':lua require("window-picker").pick()<CR>',
			{ noremap = true, silent = true }
		)
	end,
}
