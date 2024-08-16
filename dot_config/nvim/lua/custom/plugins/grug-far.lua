local leaderKey = "<localleader>r"
return {
	"MagicDuck/grug-far.nvim",
	config = function()
		require("grug-far").setup({
			opts = {
				keymaps = {
					replace = { n = leaderKey .. "r" },
					qflist = { n = leaderKey .. "q" },
					syncLocations = { n = leaderKey .. "s" },
					syncLine = { n = leaderKey .. "l" },
					close = { n = leaderKey .. "c" },
					historyOpen = { n = leaderKey .. "t" },
					historyAdd = { n = leaderKey .. "a" },
					refresh = { n = leaderKey .. "f" },
					abort = { n = leaderKey .. "b" },
					gotoLocation = { n = "<enter>" },
					pickHistoryEntry = { n = "<enter>" },
				},
			},
		})
	end,
}
