local M = {}

local ns = vim.api.nvim_create_namespace("edulint")

function M.run(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local edulint = vim.fn.systemlist("edulint check " .. filename)
    local mypy = vim.fn.systemlist("mypy --strict " .. filename)

    local diagnostics = {}

    for _, line in ipairs(edulint) do
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

    --p1_database.py:15: error: Incompatible types in assignment (expression has type "tuple[list[str], list[list[Any]]]", variable has type "list[int]")  [assignment]
    --p1_database.py:16: error: Incompatible return value type (got "list[int]", expected "list[str]")  [return-value]
    --Found 2 errors in 1 file (checked 1 source file)

    for _, line in ipairs(mypy) do
        local l, msg = line:match(":(%d+): (.+)")
        if l and  msg then
            table.insert(diagnostics, {
                lnum = tonumber(l) - 1,
                col = 0,
                message = msg,
                severity = vim.diagnostic.severity.WARN,
            })
        end
    end

    vim.diagnostic.set(ns, bufnr, diagnostics, {})
end

function M.setup()
    vim.api.nvim_create_user_command("Check", function()
        M.run(0)
    end, {})
end

return M

