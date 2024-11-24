vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>hh", ':noh<CR>') -- clear current highlights

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- terminal
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

vim.keymap.set("n", "<leader>t", function()
    local h = 15
    local bufnr = first_terminal_buffer()
    if not bufnr then
        vim.cmd(h .. 'split')
        vim.cmd('terminal')
        return
    end
    --- buffer found
    if not is_buffer_shown(bufnr) then
        vim.cmd(h .. 'split #' .. bufnr)
    end
end)

vim.keymap.set({ "n", "t" }, "<leader>q", '<cmd>q<CR>') -- to close different menus, docs, etc faster
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })


-- git fugitive
vim.keymap.set("n", "<leader>gb", "<cmd>G blame<CR>")
vim.keymap.set("n", "<leader>gl",
    "<cmd>G log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --date iso<CR>")
