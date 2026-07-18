-- winget install sharkdp.fd
-- winget install burntsushi.ripgrep.msvc

vim.pack.add({ "https://github.com/folke/snacks.nvim" })

require("snacks").setup({
	picker = {
		-- your picker configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
					["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
				},
			},
		},
	},
	indent = {},
	lazygit = {
		config = {
			os = {
				edit = "nvim {{filename}}",
				editAtLine = "nvim +{{line}} {{filename}}",
				editAtLineAndWait = "nvim +{{line}} {{filename}}",
				-- editPreset = "nvim",
			},
		},
	},
})

vim.keymap.set("n", "<leader>gg", function()
	require("snacks").lazygit()
end, { desc = "Open lazygit" })

vim.keymap.set("n", "<leader>sd", function()
	require("snacks").picker.diagnostics()
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>su", function()
	require("snacks").picker.undo()
end, { desc = "Undo History" })

vim.keymap.set("n", "<leader>uC", function()
	require("snacks").picker.colorschemes()
end, { desc = "Colorschemes" })

vim.keymap.set("n", "<leader>gs", function()
	Snacks.picker.git_status()
end, { desc = "Git Status" })

vim.keymap.set("n", "<leader>fb", function()
	Snacks.picker.buffers()
end, { desc = "Buffers" })
