-- :help conform-formatters
-- https://mason-registry.dev/registry/list

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo", "SaveWithoutFormat" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				-- cs = { "csharpier" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				markdown = { "prettierd" },
				markdown_inline = { "prettierd" },
				yaml = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				scss = { "prettierd" },
				astro = { "prettierd" },
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

			vim.keymap.set("n", "grf", function()
				require("conform").format({ async = true, lsp_fallback = true })
			end, { desc = "Format current file" })

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
