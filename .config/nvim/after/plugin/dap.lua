local dap = require('dap')

--- dap ui
local dapui = require('dapui')
dapui.setup()
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end


-- setup adapters
dap.adapters.codelldb = {
    type = 'server',
	port = '${port}',
	executable = {
        -- vim.fn.exepath('codelldb') does not work probably because mason is not initialized before
		command = vim.env.HOME .. '/.local/share/nvim/mason/bin/codelldb',
		args = { '--port', '${port}' },
	},
}
dap.configurations.cpp = { {
    name = 'Codelldb, launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    console = 'integratedTerminal',
    args = function()
        local args = vim.fn.input("Input arguments: ")
        return vim.split(args, " ")
    end

} }
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp



vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>dc', dap.continue)
vim.keymap.set('n', '<leader>do', dap.step_over)
vim.keymap.set('n', '<leader>di', dap.step_into)
vim.keymap.set('n', '<leader>du', dap.step_out)
vim.keymap.set('n', '<leader>dr', dap.repl.open)
vim.keymap.set({ 'n', 'v' }, '<leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)
