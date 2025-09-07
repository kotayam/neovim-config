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

		-- lsp servers with options
		local lsp_servers = {
			lua_ls = {
				disable_format = true,
				settings = function()
					local lazydev = require("lazydev")
					return {
						Lua = {
							workspace = {
								library = lazydev.path,
							},
						},
					}
				end,
			},
			ts_ls = {
				disable_format = true,
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
					"templ",
				},
			},
			eslint = {},
			prismals = {},
			gopls = {},
			templ = {},
			html = {
				disable_format = true,
				filetypes = { "html", "templ" },
			},
			htmx = { filetypes = { "html", "templ" } },
			cssls = { disable_format = true },
			tailwindcss = { filetypes = { "templ", "javascript", "typescript", "react", "astro" } },
			bashls = {},
			svelte = {},
			openscad_lsp = {},
			clangd = {},
		}

		-- Ensure these servers are installed
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(lsp_servers),
			automatic_installation = true, -- Auto-install if missing
			automatic_enable = false,
		})

		-- filter out disabled formatters
		local lsp_formatting = function(bufnr)
			local custom = require("custom.formatter")
			if vim.bo.filetype == "templ" then
				custom.templ_format(bufnr)
			else
				vim.lsp.buf.format({
					bufnr = bufnr,
					filter = function(client)
						local config = lsp_servers[client.name]
						local disabled = config and config.disable_format
						-- print("Client:", client.name, "-> disabled:", disabled)
						return not disabled
					end,
				})
			end
		end

		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		-- on attach function
		local on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						lsp_formatting(bufnr)
					end,
				})
			end

			local opts = { buffer = bufnr }
			-- Format file
			vim.keymap.set("n", "<leader>f", function()
				lsp_formatting(bufnr)
			end)
			-- Go to definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			-- Show references
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			-- Hover documentation
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			-- Rename symbol
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			-- Code actions
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			-- Show diagnostics
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
			vim.diagnostic.config({
				virtual_text = true,
			})
		end

		-- configure installed servers
		for name, conf in pairs(lsp_servers) do
			local opts = { on_attach = on_attach }

			if conf.settings then
				opts.settings = conf.settings
			end

			if conf.filetypes then
				opts.filetypes = conf.filetypes
			end

			lspconfig[name].setup(opts)
		end
	end,
}
