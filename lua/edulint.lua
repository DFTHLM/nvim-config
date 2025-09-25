local M = {}

local ns = vim.api.nvim_create_namespace("edulint")

function M.run(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local output = vim.fn.systemlist("edulint check " .. filename)

    local diagnostics = {}

    for _, line in ipairs(output) do
        -- Adjust this to match edulint's output format
        local l, c, msg = line:match(":(%d+):(%d+): (.+)")
        if l and c and msg then
            table.insert(diagnostics, {
                lnum = tonumber(l) - 1,
                col = tonumber(c) - 1,
                message = msg,
                severity = vim.diagnostic.severity.WARN,
            })
        end
    end

    vim.diagnostic.set(ns, bufnr, diagnostics, {})
end

function M.setup()
    vim.api.nvim_create_user_command("edulint", function()
        M.run(0)
    end, {})
end

return M

