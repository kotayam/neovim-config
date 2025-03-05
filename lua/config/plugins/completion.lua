return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        require("custom.completion")
    end,
    -- config = function()
    --     local cmp = require("cmp")
    --     local luasnip = require("luasnip")

    --     cmp.setup({
    --         snippet = {
    --             expand = function(args) luasnip.lsp_expand(args.body) end,
    --         },
    --         mapping = cmp.mapping.preset.insert({
    --             ["<C-Space>"] = cmp.mapping.complete(),
    --             ["<CR>"] = cmp.mapping.confirm({ select = true })
    --         }),
    --         sources = {
    --             { name = "nvim_lsp" },
    --             { name = "luasnip" },
    --             { name = "buffer" },
    --             { name = "path" },
    --         }
    --     })
    -- end,
}
