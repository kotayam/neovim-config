return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
					n = {
						["dd"] = actions.delete_buffer,
					},
				},
			},
			pickers = {
				find_files = {
					theme = "ivy",
				},
				git_files = {
					theme = "ivy",
				},
				buffers = {
					theme = "ivy",
				},
				live_grep = {
					theme = "ivy",
				},
				grep_string = {
					theme = "ivy",
				},
			},
			extensions = {
				fzf = {},
			},
		})
		-- load fzf
		telescope.load_extension("fzf")

		local builtin = require("telescope.builtin")
		-- find directory files
		vim.keymap.set("n", "<leader>fd", builtin.find_files)

		-- find git files
		vim.keymap.set("n", "<leader>fg", builtin.git_files)

		-- find buffers
		vim.keymap.set("n", "<leader>fb", builtin.buffers)

		-- grep files
		-- vim.keymap.set("n", "<leader>lg", builtin.live_grep)

		-- edit neovim
		vim.keymap.set("n", "<leader>en", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end)

		-- edit pacakges
		vim.keymap.set("n", "<leader>ep", function()
			builtin.find_files({
				cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
			})
		end)

		-- vim.keymap.set("n", "<leader>fg", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)

		-- find help
		vim.keymap.set("n", "<leader>fh", builtin.help_tags)

		-- custom function for live multi grep
		require("config.telescope.multigrep").setup()
	end,
}
