return {
    {
        enabled = false,
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        },
        lazy = false, -- neo-tree will lazily load itself
        ---@module "neo-tree"
        ---@type neotree.Config?
        opts = {
            -- fill any relevant options here
        },
        -- keys = {
        -- 	{
        -- 		"<leader>e",
        -- 		function()
        -- 			vim.cmd([[Neotree filesystem reveal float toggle]])
        -- 		end,
        -- 		desc = "Open explorer",
        -- 	},
        -- },
    },
    {
        "A7Lavinraj/fyler.nvim",
        dependencies = { "echasnovski/mini.icons" },
        opts = {
            mappings = {
                explorer = {
                    n = {
                        ["q"] = "CloseView",
                        ["<esc>"] = "CloseView",
                        ["<CR>"] = "Select",
                    },
                },
            },
        },
        keys = {
            {
                "<leader>e",
                function()
                    vim.cmd([[Fyler]])
                end,
                desc = "Open explorer",
            },
        },
    },
}
