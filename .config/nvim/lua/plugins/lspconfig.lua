local function lspconfig_setup(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)

    vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)

    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)

    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>f',
        function() vim.lsp.buf.format({ async = false, timeout_ms = 10000 }) end, opts)

    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>oi', function()
        vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
    end, opts)
end

return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = lspconfig_setup
        })
    end,
}
