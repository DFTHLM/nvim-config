local vim = vim

require("config.lazy")
require('lualine').setup {
	options = {
		theme = "catppuccin"
	}
}


vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd.colorscheme "catppuccin"

require("telescope").setup()
require("mason").setup()
require("mason-lspconfig").setup()
require("oil").setup({
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["<BS>"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
    },
})
require("edulint").setup()

vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = true,  -- ← real-time updates
})
vim.lsp.inlay_hint.enable(true)  -- for all buffers (Neovim 0.10+)


local builtin = require('telescope.builtin')
-- grep in visual mode finds the selected word
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

-- Open oil
vim.keymap.set("n", "<C-e>", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- grep within the current directory
vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })

-- search Workspace symbols
vim.keymap.set('n', '<C-t>', builtin.lsp_workspace_symbols, { desc = 'Workspace symbols' })

-- save with Ctrl+s
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Mason and Lazy binds
vim.keymap.set("n", "<leader>l", ":Lazy<CR>", { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>m", ":Mason<CR>", { desc = "LSP Rename" })

-- rename across the file using treesitter
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- Move the current selection
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', {noremap = true, silent = true})
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', {noremap = true, silent = true})
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', {noremap = true, silent = true})
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', {noremap = true, silent = true})
vim.keymap.set('v', '<A-k>', ':m \'<-2<CR>gv=gv', {noremap = true, silent = true})
vim.keymap.set('v', '<A-j>', ':m \'>+1<CR>gv=gv', {noremap = true, silent = true})

-- local config setup
local local_config = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(local_config) == 1 then
	dofile(local_config)
end

