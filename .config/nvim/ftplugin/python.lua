vim.treesitter.start()
vim.keymap.set("n", "<leader>rp", function()
    vim.cmd("split | terminal python " .. vim.fn.expand("%"))
end, { desc = "Run python in terminal" })
vim.keymap.set("n", "<leader>rt", function()
    vim.cmd("split | terminal pytest " .. vim.fn.expand("%"))
end, {desc = "Run pytest for the current file"})

vim.keymap.set("n", "<leader>t", function()
    local venv = vim.fn.getcwd() .. '/.venv/bin/activate'
    if not vim.fn.filereadable(venv) then
        return
    end
    require("config.term").open_terminal()
    vim.defer_fn(function()
        vim.api.nvim_feedkeys("i" .. "source " .. venv .. "\n", "n", false)
    end, 100)
end, { buffer = true })

vim.opt.colorcolumn = "140"
