local function find_in_dir(func)
    vim.ui.input({ prompt = "Directory: ", completion = "dir" }, function(dir)
        if dir and dir ~= "" then
            func({ cwd = dir })
        end
    end)
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
        { "<C-p>",      function() require("telescope.builtin").git_files() end,                            desc = "Git files" },
        { "<leader>pb", function() require("telescope.builtin").buffers() end,                              desc = "Buffers" },
        { "<leader>pg", function() require("telescope.builtin").live_grep() end,                            desc = "Live grep" },
        { "<leader>pc", function() require("telescope.builtin").colorscheme({ enable_preview = true }) end, desc = "Colorscheme" },
        { "<leader>pF", function()
            find_in_dir(require("telescope.builtin").find_files)
        end },
        { "<leader>pG", function()
            find_in_dir(require("telescope.builtin").live_grep)
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
