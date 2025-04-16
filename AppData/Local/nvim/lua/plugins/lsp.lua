-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- :help lspconfig-all

local servers = {
	lua_ls = {},
	basedpyright = {},
	csharp_ls = {},
	emmet_language_server = {},
	ts_ls = {},
	cssls = {},
}

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			local ensure_installed = vim.tbl_keys(servers or {})

			require("mason").setup({})
			require("mason-lspconfig").setup({
				ensure_installed = ensure_installed,
				automatic_installation = true,
			})

			require("mason-lspconfig").setup_handlers({
				function(server)
					local config = servers[server] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
					lspconfig[server].setup(config)
				end,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local c = vim.lsp.get_client_by_id(args.data.client_id)
					if not c then
						return
					end

					vim.diagnostic.config({ virtual_text = true })
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {
						desc = "Show error in float",
					})
				end,
			})
		end,
	},
}
