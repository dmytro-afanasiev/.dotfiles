return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    opts = {
        on_attach = function(buf)
            local gs = package.loaded.gitsigns
            local opts = { buffer = buf, silent = true }

            vim.keymap.set("n", "<leader>hs", gs.stage_hunk, opts)
            vim.keymap.set("n", "<leader>hr", gs.reset_hunk, opts)
            vim.keymap.set("n", "<leader>hp", gs.preview_hunk, opts)
            vim.keymap.set("n", "<leader>hi", gs.preview_hunk_inline, opts)
            vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
            vim.keymap.set("n", "<leader>hB", function() gs.blame() end)
        end
    }
}
