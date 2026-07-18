-- https://github.com/neovim/nvim-lspconfig/tree/master/lsp
-- :help lspconfig-all

local servers = {
	lua_ls = {},
	pyright = {},
	emmet_language_server = {},
	ts_ls = {},
	cssls = {},
	html = {},
	tailwindcss = {},
	jsonls = {},
	biome = {},
	gopls = {},
	tinymist = {
		settings = {
			formatterMode = "typstyle",
			exportPdf = "onType",
			semanticTokens = "disable",
		},
	},
	zls = {},
	astro = {},
	hls = {},
	-- nixd = {},
	clangd = {},
}

vim.pack.add({
	"https://github.com/seblyng/roslyn.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/folke/lazydev.nvim",
})

require("roslyn").setup({})
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

vim.lsp.enable(vim.tbl_keys(servers))

for server, config in pairs(servers) do
	vim.lsp.config(server, config)
end

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
		vim.keymap.set("n", "grd", vim.lsp.buf.definition, { desc = "Go to definition" })
	end,
})
