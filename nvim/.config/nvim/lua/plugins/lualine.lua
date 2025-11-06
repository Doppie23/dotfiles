return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{
				"f-person/git-blame.nvim", -- TODO: maybe use mini.git show_at_cursor()?
				opts = {
					message_template = "<author> • <date>",
					date_format = "%r",
					message_when_not_committed = "",
					display_virtual_text = 0,
				},
			},
		},
		config = function()
			local function custom_filename()
				local filename = vim.fn.expand("%:t")
				if filename == "" then
					filename = "[No Name]"
				end

				local modified = vim.bo.modified and " %#LualineModified#[+]" or ""
				return filename .. modified
			end
			local bg = require("lualine.themes.auto").normal.c.bg
			local hl_cmd = string.format("highlight LualineModified guifg=red guibg=%s gui=bold", bg)
			vim.cmd(hl_cmd)

			local git_blame = require("gitblame")
			require("lualine").setup({
				sections = {
					lualine_c = {
						custom_filename,
					},
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
