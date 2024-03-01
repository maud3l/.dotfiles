-- colorscheme
lvim.colorscheme = "onedark"
lvim.builtin.lualine.options.theme = "onedark"
lvim.transparent_window = true
lvim.builtin.nvimtree.setup.actions.open_file.window_picker.picker = "floating-big-letter"
lvim.builtin.nvimtree.setup.actions.open_file.window_picker.chars = "ASDFGHJKL"
-- Telescope config
lvim.builtin.telescope.theme = "center"
lvim.builtin.telescope.defaults.layout_strategy = "flex"
lvim.builtin.telescope.on_config_done = function(telescope)
  pcall(require("telescope").load_extension, "live_grep_args")
end
lvim.builtin.which_key.mappings.s.t = { require('telescope').extensions.live_grep_args.live_grep_args, "Live grep args", }


-- Parsers
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "json",
  "lua",
  "python",
  "yaml",
  "go",
}

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.matchup.enable = true
-- Autosession
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- Plugins
lvim.plugins = {
  { "ray-x/go.nvim" },
  -- https://github.com/nvim-telescope/telescope-live-grep-args.nvim
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  -- One Dark Theme
  { "navarasu/onedark.nvim" },
  -- Hop Navigation
  {
    "smoka7/hop.nvim",
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require 'hop'.setup {}
      vim.api.nvim_set_keymap("n", "W", ":HopWord<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopLine<cr>", { silent = true })
    end
  },
  -- Previews
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        default_mappings = true,
      }
    end
  },
  -- Better Escape
  {
    "max397574/better-escape.nvim",
    config = function()
      require("better_escape").setup()
    end,
  },
  -- Autosave
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  },
  -- Window picker
  {
      "s1n7ax/nvim-window-picker",
      version = "1.*",
      config = function()
        require("window-picker").setup({
          hint = "floating-big-letter",
          selection_chars = 'ASDFGHJKL',
      })
      end,
  },
  	-- Reopen files with saved work
	{
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				auto_session_enable_last_session = true,
				auto_save_enabled = true,
				auto_restore_enabled = true,
				auto_session_use_git_branch = true,
			})
		end,
	},
  {
  "ethanholz/nvim-lastplace",
  event = "BufRead",
  config = function()
   require("nvim-lastplace").setup({
    lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
    lastplace_ignore_filetype = {
     "gitcommit", "gitrebase", "svn", "hgcommit",
    },
    lastplace_open_folds = true,
   })
  end,
  },
    -- nvim-treesitter-context
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require'treesitter-context'.setup({
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      })
		end,
  },
  -- lsp_signature
  {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  -- trouble nvim
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  }

}

-- An awesome method to jump to windows
local picker = require('window-picker')

vim.keymap.set("n", "<C-s>", require("auto-session.session-lens").search_session, {
  noremap = true,
})

vim.keymap.set("n", ",w", function()
  local picked_window_id = picker.pick_window({
    include_current_win = true
  }) or vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window" })

-- Swap two windows using the awesome window picker
local function swap_windows()
  local window = picker.pick_window({
    include_current_win = false
  })
  local target_buffer = vim.fn.winbufnr(window)
  -- Set the target window to contain current buffer
  vim.api.nvim_win_set_buf(window, 0)
  -- Set current window to contain target buffer
  vim.api.nvim_win_set_buf(0, target_buffer)
end

vim.keymap.set('n', ',W', swap_windows, { desc = 'Swap windows' })

lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.terminal.open_mapping = "<c-t>"

-- Golang
require('go').setup({
  goimport = 'goimports', -- goimport command
  gofmt = 'gofumpt',     --gofmt cmd,
  max_line_len = 120,    -- max line length in goline format
  tag_transform = false, -- tag_transfer  check gomodifytags for details
  verbose = true,        -- output loginf in messages
  log_path = vim.fn.expand("$HOME") .. "/.config/lvim/log.log",
  lsp_cfg = true,        -- true: apply go.nvim non-default gopls setup
  lsp_gofumpt = false,   -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = true,  -- if a on_attach function provided:  attach on_attach function to gopls
  -- true: will use go.nvim on_attach if true
  -- nil/false do nothing

  lsp_codelens = true,
  -- gopls_remote_auto = true, -- set to false is you do not want to pass -remote=auto to gopls(enable share)
  -- gopls_cmd = nil,
  -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile", "/var/log/gopls.log" }
  diagnostic = {  -- set diagnostic to false to disable diagnostic
    hdlr = false, -- hook diagnostic handler and send error to quickfix
    underline = true,
    -- virtual text setup
    virtual_text = { spacing = 0, prefix = '■' },
    update_in_insert = false,
    signs = true,
  },
  dap_debug = true,        -- set to true to enable dap
  dap_debug_keymap = true, -- set keymaps for debugger
  dap_debug_gui = true,    -- set to true to enable dap gui, highly recommand
  dap_debug_vt = true,     -- set to true to enable dap virtual text
})

-- Run gofmt + goimport on save
local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimport()
  end,
  group = format_sync_grp,
})

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup { { name = "autopep8" }, }
-- Disable format on save for python
--lvim.format_on_save.enabled = true
--lvim.format_on_save.pattern = { "*.py" }
local linters = require "lvim.lsp.null-ls.linters"
linters.setup { { command = "pylint", filetypes = { "python" } } }
