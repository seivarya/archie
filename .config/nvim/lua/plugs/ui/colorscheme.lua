return {
	{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 800,
			opts = {
				italic = false,
				bold = false
			},
			config = function()
			vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
}
