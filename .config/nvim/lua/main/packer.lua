-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- themes
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
    })
    use 'nvim-tree/nvim-web-devicons'


    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'


    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- debug
    use 'mfussenegger/nvim-dap'
    use 'jay-babu/mason-nvim-dap.nvim'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

    -- docs
    use {
        'kkoomen/vim-doge',
        run = ':call doge#install()'
    }
end)
