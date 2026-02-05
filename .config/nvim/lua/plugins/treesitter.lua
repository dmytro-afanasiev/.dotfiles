return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local TS = require("nvim-treesitter")
        TS.install({
            "python",
            "bash",
            "lua",
            "markdown",
            "javascript",
            "c",
            "rust",
            "zig",
            "json",
            "yaml",
            "printf",
            "toml",
            "ini",
        })
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
}
