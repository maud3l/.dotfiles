return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			shade_terminals = false,
			highlights = {
				StatusLine = { guifg = "#ffffff", guibg = "#0E1018" },
				StatusLineNC = { guifg = "#ffffff", guibg = "#0E1018" },
			},
		})
	end,
	opts = {--[[ things you want to change go here]]
		vim.keymap.set("n", "<space>tv", ":ToggleTerm size=100 direction=vertical<cr>", { silent = true }),
	},
}
