local null_ls = require("null-ls")

-- define custom formatters
-- templ files
local templ_formatter = {
    method = null_ls.methods.FORMATTING,
    filetypes = { "templ" },
    generator = null_ls.formatter({
        command = "templ",
        args = { "fmt", "$FILENAME" },
    }),
}

return {
    templ = templ_formatter,
}
