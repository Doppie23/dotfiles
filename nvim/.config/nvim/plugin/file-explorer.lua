vim.pack.add({ "https://github.com/Doppie23/fyler.nvim.git" })

local fyler = require("fyler")
fyler.setup(opts)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "fyler",
	callback = function(ev)
		vim.keymap.set("n", "<Esc>", function()
			fyler.close()
		end, { buffer = ev.buf, nowait = true, noremap = true })
	end,
})

vim.keymap.set("n", "<leader>e", function()
	vim.cmd([[Fyler kind=float]])
end)
