return {
	{
		"aktersnurra/no-clown-fiesta.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = false, -- Enable this to disable the bg color
			styles = {
				-- You can set any of the style values specified for `:h nvim_set_hl`
				comments = {},
				functions = {},
				keywords = {},
				lsp = {},
				match_paren = {},
				type = {},
				variables = {},
			},
		},
		config = function(_, opts)
			require("no-clown-fiesta").setup(opts)

			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "no-clown-fiesta",
				callback = function()
					vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#373737" })
					vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1D1D1D" })
				end,
			})

			vim.cmd("colorscheme no-clown-fiesta")
		end,
	},
	{
		"folke/tokyonight.nvim",
		opts = {},
		lazy = true,
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function()
		-- 	-- load the colorscheme here
		-- 	vim.cmd([[colorscheme tokyonight]])
		-- end,
	},
	{
		"wtfox/jellybeans.nvim",
		opts = {},
		lazy = true,
	},
	{
		"Everblush/nvim",
		name = "everblush",
		opts = {},
		lazy = true,
	},
	{
		"webhooked/kanso.nvim",
		opts = {},
		lazy = true,
	},
	{
		"forest-nvim/sequoia.nvim",
		opts = {},
		lazy = true,
	},
	{
		"mistweaverco/retro-theme.nvim",
		opts = {},
		lazy = true,
	},
	{
		"vague2k/vague.nvim",
		opts = {},
		lazy = true,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		opts = {},
		lazy = true,
	},
}
