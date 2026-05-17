return {
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				functions = {},
				variables = {},
			},
			on_highlights = function(hl, c)
				hl.Normal = { bold = false, italic = false }
				hl.Comment = { bold = false, italic = false }
				hl.Keyword = { bold = false, italic = false }
				hl.Function = { bold = false, italic = false }
				hl.Identifier = { bold = false, italic = false }
				hl.Statement = { bold = false, italic = false }
				hl.Type = { bold = false, italic = false }
				hl.PreProc = { bold = false, italic = false }
				hl.Special = { bold = false, italic = false }
				hl.Constant = { bold = false, italic = false }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
}
