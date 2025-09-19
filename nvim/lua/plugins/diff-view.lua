return {
	{
		"sindrets/diffview.nvim",
		opts = {},
		keys = {
			{
				"<leader>gf",
				mode = { "n", "x", "o" },
				function()
					vim.cmd("DiffviewFileHistory %")
				end,
				desc = "Diffview file history",
			},
		},
	},
}
