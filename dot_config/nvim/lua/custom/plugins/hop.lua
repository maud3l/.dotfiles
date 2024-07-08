-- Hop Navigation
return {
	"smoka7/hop.nvim",
	config = function()
		-- you can configure Hop the way you like here; see :h hop-config
		require("hop").setup({})
		vim.api.nvim_set_keymap("n", "W", ":HopWord<cr>", { silent = true })
		vim.api.nvim_set_keymap("n", "L", ":HopLine<cr>", { silent = true })
	end,
}
