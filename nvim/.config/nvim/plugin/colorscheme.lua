vim.pack.add({ "https://github.com/aktersnurra/no-clown-fiesta.nvim" })

require("no-clown-fiesta").setup({
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
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "no-clown-fiesta",
	callback = function()
		vim.api.nvim_set_hl(0, "SnacksIndent", { fg = "#373737" })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1D1D1D" })
	end,
})

vim.cmd("colorscheme no-clown-fiesta")
