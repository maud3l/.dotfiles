return {
	"mistricky/codesnap.nvim",
	build = "make build_generator",
	keys = {
		{ "<leader>cs", "<Esc><cmd>CodeSnap<cr>", mode = "x", desc = "Save selected [C]ode [S]napshot into clipboard" },
	},
	opts = {
		has_breadcrumbs = true,
		watermark = "",
		show_workspace = true,
		has_line_numbers = true,
		bg_color = "#535c68",
		bg_padding = 1,
	},
}
