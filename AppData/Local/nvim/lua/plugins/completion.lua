return {
	{
		"saghen/blink.cmp",
		dependencies = "rafamadriz/friendly-snippets",

		version = "1.*",

		opts = {
			keymap = {
				preset = "enter",

				["<C-k>"] = { "select_prev", "fallback" },
				["<C-j>"] = { "select_next", "fallback" },

				["<C-n>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},

			fuzzy = {
				implementation = "prefer_rust_with_warning",
			},
			signature = { enabled = true },
		},
	},
}
