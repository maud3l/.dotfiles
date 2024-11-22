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
	opts = { --[[ things you want to change go here]]
		vim.keymap.set(
			"n",
			"<space>tv",
			":ToggleTerm size=100 direction=vertical<cr>",
			{ desc = "Open [V]ertical Terminal" },
		),
		-- Close terminal window, even if we are in insert mode
		vim.keymap.set("t", "<leader>q", "<C-\\><C-n>:q<cr>"),

		-- switch to normal mode with esc
		vim.keymap.set("t", "<ESC>", "<C-\\><C-n>"),

		-- mappings to move out from terminal to other views
		vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h"),
		vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j"),
		vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k"),
		vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l"),

		-- automatically switch to insert mode when entering a Term buffer
		vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "TermOpen" }, {
			group = vim.api.nvim_create_augroup("openTermInsert", {}),
			callback = function(args)
				-- we don't use vim.startswith() and look for test:// because of vim-test
				-- vim-test starts tests in a terminal, which we want to keep in normal mode
				if vim.endswith(vim.api.nvim_buf_get_name(args.buf), "fish") then
					vim.cmd("startinsert")
				end
			end,
		}),

		-- don't show number
		vim.api.nvim_create_autocmd("TermOpen", {
			command = [[setlocal nonumber norelativenumber]],
		}),
	},
}
