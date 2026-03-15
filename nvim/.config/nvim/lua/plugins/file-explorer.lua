return {
	{
		enabled = false,
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module "neo-tree"
		---@type neotree.Config?
		opts = {
			-- fill any relevant options here
		},
		-- keys = {
		-- 	{
		-- 		"<leader>e",
		-- 		function()
		-- 			vim.cmd([[Neotree filesystem reveal float toggle]])
		-- 		end,
		-- 		desc = "Open explorer",
		-- 	},
		-- },
	},
	{
		"A7Lavinraj/fyler.nvim",
		dependencies = { "echasnovski/mini.icons" },
		url = "https://github.com/Doppie23/fyler.nvim.git",
		config = function(_, opts)
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
		end,
		keys = {
			{
				"<leader>e",
				function()
					vim.cmd([[Fyler kind=float]])
				end,
				desc = "Open explorer",
			},
		},
	},
}
