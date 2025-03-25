return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
            },
            sections = {
                lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
                lualine_b = { 'filename' },
                lualine_c = { 'branch' },
                lualine_x = { 'encoding', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            extensions = { 'fugitive' }
        }
        )
    end
}
