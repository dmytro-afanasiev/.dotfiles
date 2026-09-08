local function resolve_context_dir()
    if vim.bo.filetype == 'netrw' then
        return vim.fn.fnamemodify(vim.b.netrw_curdir, ":.")
    end
    return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.:h")
end

local function find_in_prompted_dir(func)
    vim.ui.input({ prompt = "Directory: ", completion = "dir" }, function(dir)
        if dir and dir ~= "" then
            func({ cwd = dir })
        end
    end)
end

local function find_in_resolved_dir(func)
    func({ cwd = resolve_context_dir() })
end

-- Returns the current visual selection as a single-line string, or nil when
-- not in a visual mode.
local function get_visual_selection()
    local mode = vim.fn.mode()
    if not mode:match("[vV\22]") then
        return nil
    end

    local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
    local text = table.concat(lines, " ")
    return text ~= "" and text or nil
end

-- Runs live_grep, pre-filling the prompt with the visual selection when one
-- exists. Leaves visual mode before opening the picker.
local function live_grep_with_selection(opts)
    opts = opts or {}
    local selection = get_visual_selection()
    if selection then
        vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
        opts.default_text = selection
    end
    require("telescope.builtin").live_grep(opts)
end

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    lazy = true,
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end,                           desc = "Find files" },
        { "<leader>ps", function() require("telescope.builtin").spell_suggest() end,                        desc = "List spelling suggestions" },
        { "<leader>pw", function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,        desc = "List all symbols" },
        { "<C-p>",      function() require("telescope.builtin").git_files() end,                            desc = "Git files" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end,                              desc = "Buffers" },
        { "<leader>pg", function() live_grep_with_selection({ additional_args = { "--smart-case" } }) end,                mode = { "n", "x" }, desc = "Live grep" },
        { "<leader>gp", function() live_grep_with_selection({ additional_args = { "--fixed-strings", "--smart-case" } }) end, mode = { "n", "x" }, desc = "Live grep no regex" },
        { "<leader>pc", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Colorscheme" },
        { "<leader>pF", function()
            find_in_prompted_dir(require("telescope.builtin").find_files)
        end },
        { "<leader>pG", function()
            find_in_prompted_dir(require("telescope.builtin").live_grep)
        end },
        { "<leader>PF", function()
            find_in_resolved_dir(require("telescope.builtin").find_files)
        end },
        { "<leader>PG", function()
            find_in_resolved_dir(require("telescope.builtin").live_grep)
        end }
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
            defaults = {
                layout_config = {
                    vertical = {
                        preview_height = 0.70
                    }
                },
                layout_strategy = "vertical"
            }
        })
        telescope.load_extension("fzf")
    end
}
