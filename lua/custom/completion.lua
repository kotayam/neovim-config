vim.opt.completeopt = { "menu", "menuone", "noselect" }

local lspkind = require("lspkind")
lspkind.init {}

local cmp = require("cmp")

cmp.setup {
    sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
    },
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-y>"] = cmp.mapping(cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            },
            { "i", "c" }
        ),
    },

    -- enable luasnip to handle snippet expansion for nvim-cmp
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
}

local ls = require("luasnip")
ls.config.set_config {
    history = false,
    update_events = "TextChanged,TextChangedI",
}
