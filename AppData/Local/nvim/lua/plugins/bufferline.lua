return {
	{
		enabled = false,
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				middle_mouse_command = "bdelete! %d",
				right_mouse_command = nil,
				show_buffer_close_icons = false,
			},
		},
	},
}
