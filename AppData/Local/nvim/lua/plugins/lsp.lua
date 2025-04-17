-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- :help lspconfig-all

local servers = {
	lua_ls = {},
	pyright = {},
	csharp_ls = {},
	emmet_language_server = {},
	ts_ls = {},
	cssls = {},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = vim.tbl_keys(servers or {}),
					automatic_installation = true,
				},
			},
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			require("mason-lspconfig").setup_handlers({
				function(server)
					local config = servers[server] or {}
					vim.lsp.config(server, {
						settings = {
							[server] = config,
						},
					})
					vim.lsp.enable(server)
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					vim.diagnostic.config({ virtual_text = true })

					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
						desc = "Show diagnostics under the cursor",
					})
				end,
			})
		end,
	},
}
