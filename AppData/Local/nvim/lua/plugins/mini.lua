return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.ai").setup()
			require("mini.trailspace").setup()
			require("mini.pairs").setup()
			require("mini.surround").setup()
			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = {
						add = "┃",
						change = "┃",
						delete = "┃",
					},
				},
				mappings = {
					-- Apply hunks inside a visual/operator region
					apply = "",

					-- Reset hunks inside a visual/operator region
					reset = "<leader>gr",

					-- Hunk range textobject to be used inside operator
					-- Works also in Visual mode if mapping differs from apply and reset
					textobject = "gh",

					-- Go to hunk range in corresponding direction
					goto_first = "[H",
					goto_prev = "[h",
					goto_next = "]h",
					goto_last = "]H",
				},
			})
		end,
		keys = {
			{
				"<leader>gh",
				function()
					---@diagnostic disable-next-line: missing-parameter
					MiniDiff.toggle_overlay()
				end,
				desc = "Toggle git diff overlay",
			},
		},
	},
}
