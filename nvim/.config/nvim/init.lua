local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

if is_windows then
	vim.o.shell = "pwsh.exe"
	vim.o.shellcmdflag =
		"-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command $PSStyle.OutputRendering = 'PlainText';"
	vim.o.shellredir = "2>&1 | tee.exe %s"
	vim.o.shellpipe = "2>&1 | tee.exe %s"
	vim.o.shellquote = ""
	vim.o.shellxquote = ""
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.o.virtualedit = "block"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.showmode = false

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.breakindent = true
vim.o.wrap = false

-- folding
vim.o.foldmethod = "indent"
vim.o.foldenable = false

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Clear highlights on search when pressing <Esc> in normal mode
-- and close all floats
--  See `:help hlsearch`
vim.keymap.set("n", "<esc>", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_config(win).relative == "win" then
			vim.api.nvim_win_close(win, false)
		end
	end
	vim.cmd("nohlsearch")
	vim.api.nvim_feedkeys(vim.keycode("<esc>"), "n", false)
end, { noremap = true, silent = true })

vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<cmd>write<CR>")
vim.keymap.set("n", "g.", '/\\V\\C<C-r>"<CR>cgn<C-a><Esc>', { desc = "Replay last change" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.api.nvim_create_user_command("WrapDisable", function()
	vim.o.wrap = false
end, {})
vim.api.nvim_create_user_command("WrapEnable", function()
	vim.o.wrap = true
end, {})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- use two space indent for certain files
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"javascript",
		"typescript",
		"typescriptreact",
		"javascriptreact",
		"html",
		"css",
		"json",
		"jsonl",
		"jsonc",
		"astro",
		"haskell",
	},
	callback = function()
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
	end,
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "make",
	callback = function()
		-- use schedule, so the quickfix list becomes the focussed window
		-- vim.schedule(function()
		vim.cmd("cwindow")
		-- end)
	end,
})
vim.keymap.set("n", "<leader>m", function()
	vim.cmd("make")
end, { desc = "Run :make" })
