local prompts = {
	Eager = {
		system_prompt =
		"Do not rush to write new code or modify existing code. Ask for further clarifications, code snippet, more context, expectancy, examples, everything that can help",
	},
	NoLineNumber = { system_prompt = "Do not add line numbers to code snippets you modify or create" },
	-- Code related prompts
	Explain = "Please explain how the following code works.",
	Review = "Please review the following code and provide suggestions for improvement.",
	Tests = "Please explain how the selected code works, then generate unit tests for it.",
	Refactor = "Please refactor the following code to improve its clarity and readability.",
	FixCode = "Please fix the following code to make it work as intended.",
	FixError = "Please explain the error in the following text and provide a solution.",
	BetterNamings = "Please provide better names for the following variables and functions.",
	Documentation = "Please provide documentation for the following code.",
	SwaggerApiDocs = "Please provide documentation for the following API using Swagger.",
	SwaggerJsDocs = "Please write JSDoc for the following API using Swagger.",
	-- Text related prompts
	Summarize = "Please summarize the following text.",
	Spelling = "Please correct any grammar and spelling errors in the following text.",
	Wording = "Please improve the grammar and wording of the following text.",
	Concise = "Please rewrite the following text to make it more concise.",
}

return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
			{ "MeanderingProgrammer/render-markdown.nvim" },
		},
		opts = {
			question_header = "## User ",
			answer_header = "## Copilot ",
			error_header = "## Error ",
			prompts = prompts,
			auto_insert_mode = false,
			auto_follow_cursor = false, -- Don't follow the cursor after getting response
			show_help = false, -- Show help in virtual text, set to true if that's 1st time using Copilot Chat
			chat_autocomplete = true,
			mappings = {
				-- Use tab for completion
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				-- Close the chat
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				-- Reset the chat buffer
				reset = {
					normal = "<C-x>",
					insert = "<C-x>",
				},
				-- Submit the prompt to Copilot
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-CR>",
				},
				-- Accept the diff
				accept_diff = {
					normal = "<C-y>",
					insert = "<C-y>",
				},
				-- Yank the diff in the response to register
				yank_diff = {
					normal = "gmy",
				},
				-- Show the diff
				show_diff = {
					normal = "gmd",
				},
				-- Show the prompt
				show_info = {
					normal = "gmp",
				},
				-- Show the user selection
				show_context = {
					normal = "gms",
				},
			},
		},
		config = function(_, opts)
			-- Registers copilot-chat filetype for markdown rendering
			require("render-markdown").setup({
				file_types = { "markdown", "copilot-chat" },
			})

			-- You might also want to disable default header highlighting for copilot chat when doing this and set error header style and separator
			require("CopilotChat").setup({
				highlight_headers = false,
				separator = "---",
				error_header = "> [!ERROR] Error",
				-- rest of your config
			})
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")
			-- Use unnamed register for the selection
			opts.selection = select.unnamed

			-- Override the git prompts message
			opts.prompts.Commit = {
				prompt = "Write commit message for the change with conventional commits",
				selection = select.gitdiff,
			}
			opts.prompts.CommitStaged = {
				prompt = "Write commit message for the change with conventional commits",
				selection = function(source)
					return select.gitdiff(source, true)
				end,
			}

			chat.setup(opts)

			vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
				chat.ask(args.args, { selection = select.visual })
			end, { nargs = "*", range = true })

			-- Inline chat with Copilot
			vim.api.nvim_create_user_command("CopilotChatInline", function(args)
				chat.ask(args.args, {
					selection = select.visual,
					window = {
						layout = "vertical",
						relative = "cursor",
						width = 0.5,
						height = 0.4,
						row = 1,
					},
				})
			end, { nargs = "*", range = true })

			-- Restore CopilotChatBuffer
			vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
				chat.ask(args.args, { selection = select.buffer })
			end, { nargs = "*", range = true })

			-- Custom buffer for CopilotChat
			vim.api.nvim_create_autocmd("BufEnter", {
				pattern = "copilot-*",
				callback = function()
					vim.opt_local.relativenumber = true
					vim.opt_local.number = true

					-- Get current filetype and set it to markdown if the current filetype is copilot-chat
					local ft = vim.bo.filetype
					if ft == "copilot-chat" then
						vim.bo.filetype = "markdown"
					end
				end,
			})

			-- Add which-key mappings
			local wk = require("which-key")
			wk.add({
				{ "gm",  group = "Copilot Chat" },
				{ "gmd", desc = "Show diff" },
				{ "gmp", desc = "System prompt" },
				{ "gms", desc = "Show selection" },
				{ "gmy", desc = "Yank diff" },
			})
		end,
		event = "VeryLazy",
		keys = {
			-- Show help actions with telescope
			{
				"<leader>ah",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "[A]I - [H]elp actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ap",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "[A]I - [P]rompt actions",
			},
			-- Code related commands
			{ "<leader>ae", "<cmd>CopilotChatExplain<cr>",       desc = "[A]I - [E]xplain Code" },
			{ "<leader>at", "<cmd>CopilotChatTests<cr>",         desc = "[A]I - Generate [T]ests" },
			{ "<leader>ar", "<cmd>CopilotChatReview<cr>",        desc = "[A]I - [r]eview Code" },
			{ "<leader>aR", "<cmd>CopilotChatRefactor<cr>",      desc = "[A]I - [R]efactor Code" },
			{ "<leader>an", "<cmd>CopilotChatBetterNamings<cr>", desc = "[A]I - Better [n]aming" },
			-- Chat with Copilot in visual mode
			{
				"<leader>av",
				":CopilotChatVisual<cr>",
				mode = "x",
				desc = "[A]I [V]isual",
			},
			-- Generate commit message based on the git diff
			{
				"<leader>am",
				"<cmd>CopilotChatCommit<cr>",
				desc = "[A]I - Generate 1 line commit [M]essage",
			},
			-- Quick chat with Copilot
			{
				"<leader>aq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						vim.cmd("CopilotChatBuffer " .. input)
					end
				end,
				desc = "[A]I - [Q]uick chat",
			},
			-- Debug
			{ "<leader>ad", "<cmd>CopilotChatDebugInfo<cr>", desc = "[A]I - Debug Info" },
			-- Fix the issue with diagnostic
			{ "<leader>af", "<cmd>CopilotChatFix<cr>",       desc = "[A]I - Fix Diagnostic" },
			-- Clear buffer and chat history
			{ "<leader>al", "<cmd>CopilotChatReset<cr>",     desc = "[A]I - Clear buffer and chat history" },
			-- Toggle Copilot Chat Vsplit
			{ "<leader>av", "<cmd>CopilotChatToggle<cr>",    desc = "[A]I - Toggle" },
			-- Stop Copilot Chat output
			{ "<leader>as", "<cmd>CopilotChatStop<cr>",      desc = "[A]I - [S]top Output" },
		},
	},
}
