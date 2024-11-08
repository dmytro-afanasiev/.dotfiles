local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf, remap = false }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set("n", "<leader>vd", '<cmd> lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set("n", "[d", '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
        vim.keymap.set("n", "]d", '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)

        vim.keymap.set('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = false, timeout_ms = 10000})<cr>',
            opts)
        vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

local handlers = {
    ['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' }),
}

require("mason").setup()
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({ handlers = handlers })
        end,
    },
    ensure_installed = {"rust_analyzer@2024-10-21"}
})

local cmp = require('cmp')

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
    },
    mapping = cmp.mapping.preset.insert({
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
        -- Scroll up and down in the completion documentation
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
    }),
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = 'E',
            [vim.diagnostic.severity.WARN] = 'W',
            [vim.diagnostic.severity.HINT] = 'H',
            [vim.diagnostic.severity.INFO] = 'I',
        },
    },
    virtual_text = false,
    underline = true,
    float = {
        header = false,
        border = 'rounded',
        source = "if_many"
    }
})
