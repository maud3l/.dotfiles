local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- add this plugin as dependency for lualine
		"bwpge/lualine-pretty-path",
	},
	opts = {
		icons_enabled = true,
		sections = {
			lualine_b = { { "diff", source = diff_source } },
			lualine_c = { "pretty_path" },
		},
		inactive_sections = {
			lualine_c = { "pretty_path" },
		},
	},
}
