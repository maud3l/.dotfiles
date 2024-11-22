-- default config
local default_config = {
	ft_blocklist = {},
	patterns = {},
	trim_on_write = true,
	trim_trailing = true,
	trim_last_line = true,
	trim_first_line = true,
	highlight = false,
	highlight_bg = "#ff0000", -- or 'red'
	highlight_ctermbg = "red",
	notifications = true,
}

return {
	require("lazy").setup({
		"cappyzawa/trim.nvim",
		opts = {},
	}, default_config),
}
