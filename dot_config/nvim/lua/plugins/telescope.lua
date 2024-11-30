return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		{
			"nvim-telescope/telescope-frecency.nvim",
			config = function()
				require("telescope").load_extension("frecency")
			end,
		},
		"nvim-telescope/telescope-live-grep-args.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
		{
			"danielfalk/smart-open.nvim",
			dependencies = {
				"kkharji/sqlite.lua",
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			},
		},
	},
	config = function()
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = require("telescope.builtin").move_selection_previous, -- move to prev result
						["<C-j>"] = require("telescope.builtin").move_selection_next, -- move to next result
					},
				},
			},
			pickers = {
				colorscheme = {
					enable_preview = true,
				},
				find_files = {
					theme = "ivy",
					layout_config = { height = 0.4 },
					find_command = { "rg", "--glob", "!vendor/**", "--glob", "!go.mod", "--glob", "!go.sum" },
				},

				git_files = { theme = "ivy", layout_config = { height = 0.4 } },
				live_grep = {
					theme = "ivy",
					layout_config = { height = 0.4 },
					additional_args = function()
						return { "--glob", "!vendor/**", "--glob", "!go.mod", "--glob", "!go.sum" }
					end,
				},

				live_grep_args = { theme = "ivy", layout_config = { height = 0.4 } },
				buffers = { theme = "ivy", layout_config = { height = 0.4 } },
				keymaps = { theme = "ivy", layout_config = { height = 0.4 } },
				file_browser = { theme = "ivy", layout_config = { height = 0.4 } },
				treesitter = { theme = "ivy", layout_config = { height = 0.4 } },
				help_tags = { theme = "ivy", layout_config = { height = 0.4 } },
				man_pages = {
					sections = { "1", "2", "3" },
					theme = "ivy",
					layout_config = { height = 0.4 },
				},
				lsp_references = { theme = "ivy", layout_config = { height = 0.4 } },
				smart_open = { theme = "ivy", layout_config = { height = 0.4 } },
			},
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--hidden",
				"--glob=!.git/",
				"--glob=!vendor/",
				"--glob=!go.sum",
				"--glob=!go.mod/",
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
				live_grep_args = {
					auto_quoting = true,                   -- enable/disable auto-quoting
					mappings = {                           -- extend mappings
						i = {
							["<C-k>"] = require("telescope-live-grep-args.actions")
							.quote_prompt(),       -- extracted as separate function,
						},
					},
					additional_args = function()
						return { "--glob", "!vendor/**", "--glob", "!go.mod", "--glob", "!go.sum" }
					end,

					theme = "ivy",
					layout_config = { height = 0.4 },
				},
				frecency = {
					auto_validate = false,
					matcher = "fuzzy",
					path_display = { "shorten" },
					db_safe_mode = false,
				},
			},
		})

		-- Enable Telescope extensions if they are installed
		pcall(require("telescope").load_extension, "live_grep_args")
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")
		pcall(require("telescope").load_extension, "smart-open")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set(
			"n",
			"<leader>sg",
			require("telescope").extensions.live_grep_args.live_grep_args,
			{ desc = "[S]earch by [G]rep" }
		)
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sre", builtin.resume, { desc = "[S]earch [Re]sume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

		-- It's also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })

		-- Smart files
		vim.keymap.set("n", "<leader>ss", function()
			local ignores = require("telescope._extensions.smart_open.default_config").ignore_patterns

			require("telescope").extensions.smart_open.smart_open({
				theme = "ivy",
				layout_config = { height = 0.4 },
				cwd_only = true,
				ignore_patterns = vim.list_extend(ignores, { "node_modules/*", "vendor/*" }),
			})
		end, { desc = "[S]earch [S]mart files" })
	end,
}
