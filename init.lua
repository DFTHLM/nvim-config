require("config.lazy")
require('lualine').setup {
    options = {
        theme = "catppuccin"
    }
}

vim.cmd.colorscheme "catppuccin"

vim.opt.number = true
vim.opt.relativenumber = true

require("telescope").setup {
	extensions = {
		file_browser = {
			display_stat = { date = true, size = true },
		}
	}
}

require("telescope").load_extension "file_browser"

local builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-e>", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
vim.keymap.set('n', '<C-t>', builtin.treesitter, { desc = 'Telescope treesitter' })

vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

