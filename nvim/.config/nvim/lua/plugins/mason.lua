return {
    {
        "mason-org/mason.nvim",
        enabled = vim.fn.filereadable("/etc/NIXOS") == 0,
        opts = {},
    },
}
