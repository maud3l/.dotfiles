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
		"mrbjarksen/neo-tree-diagnostics.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal<CR>", { desc = "NeoTree reveal" } },
	},
	opts = {
		commands = {
			copy_selector = function(state)
				local node = state.tree:get_node()
				local filepath = node:get_id()
				local filename = node.name
				local modify = vim.fn.fnamemodify

				local vals = {
					["CONTENT"] = table.concat(vim.fn.readfile(filepath), "\n"),
					["BASENAME"] = modify(filename, ":r"),
					["EXTENSION"] = modify(filename, ":e"),
					["FILENAME"] = filename,
					["PATH (CWD)"] = modify(filepath, ":."),
					["PATH (HOME)"] = modify(filepath, ":~"),
					["PATH"] = filepath,
					--["GIT_LINK"] = vim.cmd("GitLink"),
					--["GIT_LINK_DEFAULT"] = vim.cmd("GitLink default_branch"),
				}

				local options = vim.tbl_filter(function(val)
					return vals[val] ~= ""
				end, vim.tbl_keys(vals))
				if vim.tbl_isempty(options) then
					vim.notify("No values to copy", vim.log.levels.WARN)
					return
				end
				table.sort(options)
				vim.ui.select(options, {
					prompt = "Choose to copy to clipboard:",
					format_item = function(item)
						return ("%s: %s"):format(item, vals[item])
					end,
				}, function(choice)
					local result = vals[choice]
					if result then
						vim.notify(("Copied: `%s`"):format(result))
						vim.fn.setreg("+", result)
					end
				end)
			end,
		},
		filtered_items = {
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time
				--               -- the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
		},
		close_if_last_window = true,
		filesystem = {
			window = {
				mappings = {
					["<space>"] = {
						"toggle_node",
						nowait = true, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["v"] = "vsplit_with_window_picker",
					["\\"] = "close_window",
					["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
					["<esc>"] = "cancel",
					["Y"] = "copy_selector",
					["o"] = "open",
				},
			},
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function(arg)
					vim.cmd([[
              setlocal relativenumber
            ]])
				end,
			},
		},
		diagnostics = {
			components = {
				linenr = function(config, node)
					local lnum = tostring(node.extra.diag_struct.lnum + 1)
					local pad = string.rep(" ", 4 - #lnum)
					return {
						{
							text = pad .. lnum,
							highlight = "LineNr",
						},
						{
							text = "▕ ",
							highlight = "NeoTreeDimText",
						},
					}
				end,
			},
			renderers = {
				file = {
					{ "indent" },
					{ "icon" },
					{ "grouped_path" },
					{ "name",             highlight = "NeoTreeFileNameOpened" },
					{ "diagnostic_count", highlight = "NeoTreeDimText",       severity = "Error", right_padding = 0 },
					{ "diagnostic_count", highlight = "NeoTreeDimText",       severity = "Warn",  right_padding = 0 },
					{ "diagnostic_count", highlight = "NeoTreeDimText",       severity = "Info",  right_padding = 0 },
					{ "diagnostic_count", highlight = "NeoTreeDimText",       severity = "Hint",  right_padding = 0 },
					{ "clipboard" },
				},
				diagnostic = {
					{ "indent" },
					{ "icon" },
					{ "linenr" },
					{ "name" },
				},
			},
		},
	},
}
