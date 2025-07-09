return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        {
            "mason-org/mason.nvim",
            build = ":MasonUpdate", -- Automatically update registries
            config = true, -- Uses default config
        },
        "neovim/nvim-lspconfig",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
    },
    config = function()
        require("mason").setup()

        local mason_lspconfig = require("mason-lspconfig")
        local lspconfig = require("lspconfig")

        -- Ensure these servers are installed
        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls", -- Lua
                "ts_ls", -- TypeScript/JavaScript
                "eslint",
                "prismals",
                "gopls",
                "templ",
                "html",
                "htmx",
                "cssls",
                "tailwindcss",
                "bashls",
                "svelte",
            },
            automatic_installation = true, -- Auto-install if missing
        })

        -- Auto-configure installed servers
        local servers = mason_lspconfig.get_installed_servers()
        for _, server_name in ipairs(servers) do
            local opts = {}

            -- add lazydev support for lua_ls
            if server_name == "lua_ls" then
                local lazydev = require("lazydev")
                opts = {
                    settings = {
                        Lua = {
                            workspace = {
                                library = lazydev.path,
                            },
                        },
                    },
                }
            elseif server_name == "ts_ls" then
                opts = {
                    "javascript",
                    "javascriptreact",
                    "javascript.jsx",
                    "typescript",
                    "typescriptreact",
                    "typescript.tsx",
                    "templ",
                }
            elseif server_name == "html" then
                opts = { filetypes = { "html", "templ" } }
            elseif server_name == "htmx" then
                opts = { filetypes = { "html", "templ" } }
            elseif server_name == "tailwindcss" then
                opts = { filetypes = { "templ", "javascript", "typescript", "react", "astro" } }
            end
            lspconfig[server_name].setup(opts)
        end

        -- LSP keybindings (attach on active LSP)
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local opts = { buffer = args.buf }
                -- Go to definition
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                -- Show references
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                -- Hover documentation
                -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                -- Rename symbol
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                -- Code actions
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                -- Show diagnostics
                vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
                vim.diagnostic.config({
                    virtual_text = true,
                })
            end,
        })
    end,
}
