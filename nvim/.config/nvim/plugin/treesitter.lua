vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

-- :lua vim.print(require("nvim-treesitter").get_available())
-- require('nvim-treesitter').install { 'rust', 'javascript', 'zig' }

-- https://www.reddit.com/r/neovim/comments/1sezoxf/nvimtreesitter_auto_install_parsers/
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(ev.match)
		local available_langs = require("nvim-treesitter").get_available()
		local is_available = vim.tbl_contains(available_langs, lang)
		if is_available then
			local installed_langs = require("nvim-treesitter").get_installed()
			local installed = vim.tbl_contains(installed_langs, lang)
			if not installed then
				require("nvim-treesitter").install(lang):wait()
			end

			vim.treesitter.start()

			vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo[0][0].foldmethod = "expr"

			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
