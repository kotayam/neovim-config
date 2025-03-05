return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "lua", "javascript", "typescript", "vim", "tsx", "json", "css", "html", "yaml", "prisma", "markdown", "markdown_inline", "vimdoc" },
            sync_install = false,
            highlight = { enable = true },
        })
    end
}
