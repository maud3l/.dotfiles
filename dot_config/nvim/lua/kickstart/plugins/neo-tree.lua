-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
	},
	event_handlers = {
		event = "neo_tree_buffer_enter",
		handler = function()
			vim.cmd([[
					setlocal number
				]])
		end,
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["v"] = "vsplit_with_window_picker",
					["\\"] = "close_window",
				},
			},
		},
	},
}
