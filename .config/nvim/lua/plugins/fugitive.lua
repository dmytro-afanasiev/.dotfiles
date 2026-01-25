return {
    "tpope/vim-fugitive",
    lazy = true,
    keys = {
        { "<leader>gb", "<cmd>G blame<cr>",                                                                                                                        desc = "Show git blame" },
        { "<leader>gl", "<cmd>G log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cd) %C(bold blue)<%an>%Creset' --date iso<CR>", desc = "Show git log" }
    }
}
