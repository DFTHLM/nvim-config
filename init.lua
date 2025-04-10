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
vim.keymap.set("n", "<C-e>", ":Telescope file_browser path=%:p:h select_buffer=true hidden=true<CR>")

vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set("v", "<C-f>", function()
    local function get_visual_selection()
        -- Yank current visual selection into the 'v' register
        --
        -- Note that this makes no effort to preserve this register
        vim.cmd('noau normal! "vy"')

        return vim.fn.getreg('v')
    end

    builtin.grep_string {
        search = get_visual_selection(),
    }
end
, { desc = 'Telescope grep string' })

vim.keymap.set('n', '<C-t>', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover Docs" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })


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

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {noremap = true, silent = true})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {noremap = true, silent = true})
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {noremap = true, silent = true})
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {noremap = true, silent = true})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {noremap = true, silent = true})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {noremap = true, silent = true})

local local_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(local_config) == 1 then
    dofile(local_config)
end


