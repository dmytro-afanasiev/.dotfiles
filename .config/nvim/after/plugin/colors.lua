function CS(name)
    vim.cmd.colorscheme(name or 'rose-pine')
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

CS()
require('nvim-web-devicons').setup()
