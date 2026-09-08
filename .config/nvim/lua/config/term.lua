local M = {}

M.height = 15


local function first_terminal_buffer()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[bufnr].buftype == 'terminal' then
            return bufnr
        end
    end
end

local function is_buffer_shown(bufnr)
    for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_buf(win_id) == bufnr then
            return true
        end
    end
    return false
end

function M.open_terminal()
    local bufnr = first_terminal_buffer()
    if not bufnr then
        vim.cmd(M.height .. 'split')
        vim.cmd('terminal')
        return
    end
    --- buffer found
    if not is_buffer_shown(bufnr) then
        vim.cmd(M.height .. 'split #' .. bufnr)
    end

end

return M
