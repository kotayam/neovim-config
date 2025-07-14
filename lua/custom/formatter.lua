-- define custom formatters
-- templ files
local templ_format = function(bufnr)
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local cmd = "templ fmt " .. vim.fn.shellescape(filename)

    if vim.bo.modified then
        vim.cmd("write")
    end

    vim.fn.jobstart(cmd, {
        on_exit = function()
            -- reload the buffer only if it is still the current buffer
            if vim.api.nvim_get_current_buf() == bufnr then
                vim.cmd("e!")
            end
        end,
    })
end

return { templ_format = templ_format }
