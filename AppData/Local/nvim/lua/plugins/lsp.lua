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
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onType",
			semanticTokens = "disable",
		},
	},
}

return {
	{
		"seblyng/roslyn.nvim",
		dependencies = {
			"mason-org/mason.nvim",
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
			"mason-org/mason.nvim",
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {
					ensure_installed = vim.tbl_keys(servers or {}),
					automatic_installation = true,
					automatic_enable = true,
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
			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
			end

			require("mason-lspconfig").setup()

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

					-- https://github.com/adibhanna/nvim/blob/main/lua/core/lsp.lua#L33-L54
					vim.api.nvim_create_user_command("LspRestart", function()
						local bufnr = vim.api.nvim_get_current_buf()
						local clients
						if vim.lsp.get_clients then
							clients = vim.lsp.get_clients({ bufnr = bufnr })
						else
							---@diagnostic disable-next-line: deprecated
							clients = vim.lsp.get_active_clients({ bufnr = bufnr })
						end

						for _, client in ipairs(clients) do
							vim.lsp.stop_client(client.id)
						end

						vim.defer_fn(function()
							vim.cmd("edit")
						end, 100)
					end, {})
				end,
			})
		end,
	},
}
