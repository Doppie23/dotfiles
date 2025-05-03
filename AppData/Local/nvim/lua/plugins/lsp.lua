-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- :help lspconfig-all

local servers = {
	lua_ls = {},
	pyright = {},
	emmet_language_server = {},
	ts_ls = {},
	cssls = {},
	html = {},
	jsonls = {},
	gopls = {},
}

return {
	{
		"seblyng/roslyn.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		ft = "cs",
		opts = {
			-- your configuration comes here; leave empty for default settings
			-- NOTE: You must configure `cmd` in `config.cmd` unless you have installed via mason
		},
		config = function(_, opts)
			require("roslyn").setup(opts)
			if not require("mason-registry").is_installed("roslyn") then
				vim.cmd("MasonInstall roslyn")
			end
		end,
	},
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
