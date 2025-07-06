return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup {
            size = 20,
            shell = '/bin/zsh',
            open_mapping = [[<leader>t]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = false,
            persist_size = true,
            direction = 'horizontal',
            close_on_exit = true,
        }
    end,
}
