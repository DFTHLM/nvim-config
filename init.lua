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
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

require("mason").setup()
require("mason-lspconfig").setup()

require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
    end,
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

