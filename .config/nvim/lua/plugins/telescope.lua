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
        { "<leader>pg", function() require("telescope.builtin").live_grep() end,                            desc = "Live grep" },
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
            }
        })
        telescope.load_extension("fzf")
    end

}
