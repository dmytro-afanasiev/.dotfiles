return {
    'saghen/blink.cmp',
    event = { "BufReadPost", "BufNewFile" },
    lazy = true,
    opts = {
        keymap = { preset = 'enter' },
        appearance = {
            nerd_font_variant = 'mono',
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    build = "cargo build --release",
    opts_extend = { "sources" },
}
