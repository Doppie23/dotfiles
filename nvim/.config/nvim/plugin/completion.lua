vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
	"https://github.com/rafamadriz/friendly-snippets",
})

require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<Up>"] = {},
		["<Down>"] = {},
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
	signature = { enabled = true },
})
