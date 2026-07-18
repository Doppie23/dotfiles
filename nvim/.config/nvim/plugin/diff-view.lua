vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

require("diffview").setup({})

vim.keymap.set("n", "<leader>gf", function()
	vim.cmd("DiffviewFileHistory %")
end, { desc = "Diffview file history" })
