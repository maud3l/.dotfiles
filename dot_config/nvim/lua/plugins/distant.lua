return {
	"chipsenkbeil/distant.nvim",
	lazy = true,
	build = { "DistantInstall" },
	cmd = { "DistantLaunch", "DistantRun" },
	config = function()
		require("distant"):setup({
			buffer = {
				watch = {
					enabled = true,
				},
			},
		})
	end,
}
