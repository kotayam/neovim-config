return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"javascript",
				"typescript",
				"vim",
				"tsx",
				"json",
				"css",
				"html",
				"yaml",
				"prisma",
				"markdown",
				"markdown_inline",
				"vimdoc",
				"go",
				"templ",
				"make",
				"bash",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = {},
			highlight = { enable = true },
		})
	end,
}
