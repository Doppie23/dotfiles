vim.pack.add({ "https://github.com/echasnovski/mini.nvim" })

require("mini.ai").setup()
require("mini.trailspace").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {
			add = "┃",
			change = "┃",
			delete = "┃",
		},
	},
	mappings = {
		-- Apply hunks inside a visual/operator region
		apply = "",

		-- Reset hunks inside a visual/operator region
		reset = "<leader>gr",

		-- Hunk range textobject to be used inside operator
		-- Works also in Visual mode if mapping differs from apply and reset
		textobject = "gh",

		-- Go to hunk range in corresponding direction
		goto_first = "[H",
		goto_prev = "[h",
		goto_next = "]h",
		goto_last = "]H",
	},
})
require("mini.git").setup()

local function diagnostics()
	local counts = vim.diagnostic.count(0)

	local parts = {}

	if (counts[vim.diagnostic.severity.ERROR] or 0) > 0 then
		table.insert(parts, {
			hl = "DiagnosticError",
			strings = { " " .. counts[vim.diagnostic.severity.ERROR] },
		})
	end

	if (counts[vim.diagnostic.severity.WARN] or 0) > 0 then
		table.insert(parts, {
			hl = "DiagnosticWarn",
			strings = { " " .. counts[vim.diagnostic.severity.WARN] },
		})
	end

	if (counts[vim.diagnostic.severity.INFO] or 0) > 0 then
		table.insert(parts, {
			hl = "DiagnosticInfo",
			strings = { " " .. counts[vim.diagnostic.severity.INFO] },
		})
	end

	if (counts[vim.diagnostic.severity.HINT] or 0) > 0 then
		table.insert(parts, {
			hl = "DiagnosticHint",
			strings = { "󰌵 " .. counts[vim.diagnostic.severity.HINT] },
		})
	end

	return parts
end

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			-- local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			-- local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local filename = "%f%m%r"
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })

			local groups = {
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git } },
			}

			vim.list_extend(groups, diagnostics())

			vim.list_extend(groups, {
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { location } },
			})

			return MiniStatusline.combine_groups(groups)
		end,
	},
})

vim.keymap.set("n", "<leader>gh", function()
	---@diagnostic disable-next-line: missing-parameter
	MiniDiff.toggle_overlay()
end, { desc = "Toggle git diff overlay" })

vim.keymap.set("n", "<leader>gb", function()
	MiniGit.show_at_cursor()
end, { desc = "Show at cursor" })
