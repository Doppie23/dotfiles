return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"f-person/git-blame.nvim",
				opts = {
					message_template = "<author> • <date>",
					date_format = "%r",
					message_when_not_committed = "",
					display_virtual_text = 0,
				},
			},
		},
		config = function()
			local git_blame = require("gitblame")
			require("lualine").setup({
				sections = {
					lualine_x = {
						{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available },
						"encoding",
						"fileformat",
						"filetype",
					},
				},
			})
		end,
	},
}
