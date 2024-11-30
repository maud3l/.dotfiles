return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- cmp_nvim_lsp
		"neovim/nvim-lspconfig", -- lspconfig
		"onsails/lspkind-nvim", -- lspkind (VS pictograms)
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
			dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
				-- https://github.com/rafamadriz/friendly-snippets/blob/main/snippets/go.json
			end,
		},
		{ "saadparwaiz1/cmp_luasnip", enabled = true },
		"zbirenbaum/copilot-cmp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
	},
	config = function()
		local luasnip = require("luasnip")
		local types = require("luasnip.util.types")
		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		-- Display virtual text to indicate snippet has more nodes
		luasnip.config.setup({
			ext_opts = {
				[types.choiceNode] = {
					active = { virt_text = { { "⇥", "GruvboxRed" } } },
				},
				[types.insertNode] = {
					active = { virt_text = { { "⇥", "GruvboxBlue" } } },
				},
			},
		})

		local cmp = require("cmp")
		local lspkind = require("lspkind")

		cmp.setup({
			require("cmp").setup({
				sources = {
					{ name = "buffer" },
				},
			}),
			-- `/` cmdline setup.
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			}),

			-- `:` cmdline setup.
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			}),

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("copilot.suggestion").is_visible() then
						require("copilot.suggestion").accept()
					elseif luasnip.expandable() then
						luasnip.expand()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif check_backspace() then
						fallback()
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, {
					"i",
					"s",
				}),
				["<C-Space>"] = cmp.mapping.complete({}),
				["<C-l>"] = cmp.mapping(function()
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					end
				end, { "i", "s" }),
				["<C-h>"] = cmp.mapping(function()
					if luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			}),
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = 70,
					show_labelDetails = true,
				}),
			},
		})

		local lspconfig = require("lspconfig")

		-- All languages: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

		-- Default lspconfig values for Go are set by `navigator`
		-- Go: go install golang.org/x/tools/gopls@latest

		-- Python: brew install pyright
		-- lspconfig["pyright"].setup({})
	end,
}
