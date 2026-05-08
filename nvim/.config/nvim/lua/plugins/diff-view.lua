return {
	{
		"sindrets/diffview.nvim",
		opts = {},
		cmd = { "DiffviewOpen" },
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
