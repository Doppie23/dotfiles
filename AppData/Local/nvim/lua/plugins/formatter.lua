-- :help conform-formatters
-- https://mason-registry.dev/registry/list

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "SaveWithoutFormat" },
		dependencies = {
			"mason-org/mason.nvim",
			{ "zapling/mason-conform.nvim", opts = {} },
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				cs = { "csharpier" },
				javascript = { "prettier" },
				javascriptreact = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				jsonc = { "prettier" },
				markdown = { "prettier" },
				markdown_inline = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				scss = { "prettier" },
				astro = { "prettier" },
				typst = { "tinymist" },
				-- -- Conform will run multiple formatters sequentially
				-- python = { "isort", "black" },
				-- -- You can customize some of the format options for the filetype (:help conform.format)
				-- rust = { "rustfmt", lsp_format = "fallback" },
				-- -- Conform will run the first available formatter
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
				-- -- Use the "_" filetype to run formatters on filetypes that don't
				-- -- have other formatters configured.
				-- ["_"] = { "trim_whitespace" },
			},
			format_on_save = { lsp_format = "fallback" },
			formatters = {
				prettier = { command = "prettier" },
			},
		},
		config = function(_, opts)
			local format_opts = opts.format_on_save

			opts.format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return format_opts
			end

			require("conform").setup(opts)

			vim.api.nvim_create_user_command("FormatDisable", function(args)
				if args.bang then
					-- FormatDisable! will disable formatting just for this buffer
					vim.b.disable_autoformat = true
				else
					vim.g.disable_autoformat = true
				end
				vim.notify("Format on save " .. (args.bang and "disabled for current buffer" or "globally disabled"))
			end, {
				desc = "Disable autoformat-on-save",
				bang = true,
			})
			vim.api.nvim_create_user_command("FormatEnable", function()
				vim.b.disable_autoformat = false
				vim.g.disable_autoformat = false
				vim.notify("Format on save enabled")
			end, {
				desc = "Re-enable autoformat-on-save",
			})

			vim.api.nvim_create_user_command("SaveWithoutFormat", function()
				local was_disabled = vim.b.disable_autoformat
				vim.b.disable_autoformat = true

				vim.cmd("write")

				vim.b.disable_autoformat = was_disabled
			end, {
				desc = "Save without formatting",
			})
		end,
	},
}
